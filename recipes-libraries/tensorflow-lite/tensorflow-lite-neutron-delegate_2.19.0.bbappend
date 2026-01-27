# Fix KleidiAI hash in XNNPACK after TensorFlow is downloaded
do_configure:prepend() {
    TFLITE_SRC="${WORKDIR}/sources-unpack/tfgit/tensorflow/lite/tools/cmake/modules/xnnpack.cmake"

    # Wait for initial configure to download TensorFlow if needed
    if [ ! -f "${TFLITE_SRC}" ]; then
        echo "TensorFlow not yet downloaded, triggering initial configure..."
        cd ${B}
        cmake ${EXTRA_OECMAKE} 2>&1 | tee cmake_init.log || true
    fi

    # Now modify xnnpack.cmake if it exists
    if [ -f "${TFLITE_SRC}" ]; then
        echo "Patching ${TFLITE_SRC} to fix KleidiAI hash..."

        # Check if already patched
        if ! grep -q "PATCH_COMMAND" "${TFLITE_SRC}"; then
            # Create patch content in a temporary file
            cat > ${WORKDIR}/patch_commands.txt << 'ENDPATCH'
  PATCH_COMMAND sed -i "s/f3ea4fce53f3b31076958dbff229f0048dae15bf454929673c78292a56279d52/3564707756473a165ddb3cf670187a4eeb2189c71c5ef01e865567cab071daac/g" cmake/DownloadKleidiAI.cmake || true
  COMMAND sed -i "s/f3ea4fce53f3b31076958dbff229f0048dae15bf454929673c78292a56279d52/3564707756473a165ddb3cf670187a4eeb2189c71c5ef01e865567cab071daac/g" WORKSPACE MODULE.bazel || true
ENDPATCH

            # Insert after the SOURCE_DIR line using awk
            awk '/SOURCE_DIR.*xnnpack"/ { print; while(getline < "'${WORKDIR}'/patch_commands.txt") print; next }1' \
                "${TFLITE_SRC}" > "${TFLITE_SRC}.tmp"
            mv "${TFLITE_SRC}.tmp" "${TFLITE_SRC}"

            echo "Patched xnnpack.cmake successfully"
        fi

        # Clean up any failed builds
        rm -rf ${B}/kleidiai-download ${B}/kleidiai-source ${B}/xnnpack
    else
        echo "WARNING: Could not find ${TFLITE_SRC}"
    fi
}
