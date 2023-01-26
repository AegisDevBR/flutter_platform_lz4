package br.dev.aegis.flutter_platform_lz4

import org.apache.commons.compress.compressors.lz4.BlockLZ4CompressorInputStream
import org.apache.commons.compress.compressors.lz4.BlockLZ4CompressorOutputStream
import java.io.ByteArrayInputStream
import java.io.ByteArrayOutputStream

fun teste(): ByteArray {
    val input = "Test".toByteArray()
    val outputStream = ByteArrayOutputStream()
    val lz4OutputStream = BlockLZ4CompressorOutputStream(outputStream)

    lz4OutputStream.write(input)

    lz4OutputStream.close()

    println(outputStream.toByteArray())

    return outputStream.toByteArray()
}

fun decompressLZ4Block(byteArray: ByteArray, decodedLength: Int): ByteArray? {
    val inputStream = ByteArrayInputStream(byteArray)
    val lz4InputStream = BlockLZ4CompressorInputStream(inputStream)
    val outputStream = ByteArrayOutputStream(decodedLength)

    return try {
        val buffer = ByteArray(decodedLength)
        var n: Int
        while (-1 != lz4InputStream.read(buffer).also { n = it }) {
            outputStream.write(buffer, 0, n)
        }

        outputStream.toByteArray()
    } catch (e: Error) {
        null
    } finally {
        lz4InputStream.close()
        outputStream.close()
    }
}
