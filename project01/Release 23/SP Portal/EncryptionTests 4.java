package com.company.Test;

import org.junit.Assert;
import org.junit.Ignore;
import org.junit.Test;

import javax.crypto.BadPaddingException;
import javax.crypto.Cipher;
import javax.crypto.IllegalBlockSizeException;
import javax.crypto.NoSuchPaddingException;
import javax.crypto.spec.IvParameterSpec;
import javax.crypto.spec.SecretKeySpec;
import java.io.File;
import java.io.IOException;
import java.nio.charset.StandardCharsets;
import java.nio.file.Files;
import java.security.InvalidAlgorithmParameterException;
import java.security.InvalidKeyException;
import java.security.KeyFactory;
import java.security.NoSuchAlgorithmException;
import java.security.PublicKey;
import java.security.spec.InvalidKeySpecException;
import java.security.spec.X509EncodedKeySpec;
import java.util.Base64;

@Ignore
public class EncryptionTests {
    private static final String RSA_ENCRYPTION_ALGORITHM = "RSA/ECB/PKCS1Padding";
    private static final String RSA_ALGORITHM = "RSA";
    private static final String RSA_KEY_PATH = "C:\\Users\\jrferreira\\IdeaProjects\\Encryptor-test\\src\\com\\company\\Keys\\mz-prod\\g2_public_key.der";
    private static final String AES_ENCRYPTION_ALGORITHM = "AES/CBC/NoPadding";
    private static final String AES_ALGORITHM = "AES";

    /**
     * Encrypt the provided value using RSA with the Key retrieved from the file.
     *
     * @param text text to encrypt
     * @return encrypted text
     */
    private static String encryptRSA(final String text) {
        try {
            final Cipher cipher = Cipher.getInstance(RSA_ENCRYPTION_ALGORITHM);
            cipher.init(Cipher.ENCRYPT_MODE, getRSAPublicKeyFromFile());
            final byte[] cipherText = cipher.doFinal(text.getBytes());
            return Base64.getEncoder().encodeToString(cipherText);
        } catch (final Exception e) {
            e.printStackTrace();
            return "Failed to encrypt text: " + text;
        }
    }

    /**
     * Get the RSA public key from the file
     *
     * @return public key
     * @throws IOException              IOException
     * @throws NoSuchAlgorithmException NoSuchAlgorithmException
     * @throws InvalidKeySpecException  InvalidKeySpecException
     */
    private static PublicKey getRSAPublicKeyFromFile() throws IOException, NoSuchAlgorithmException, InvalidKeySpecException {
        final byte[] keyBytes = Files.readAllBytes(new File(RSA_KEY_PATH).toPath());
        final X509EncodedKeySpec publicKeySpec = new X509EncodedKeySpec(keyBytes);
        final KeyFactory keyFactory = KeyFactory.getInstance(RSA_ALGORITHM);
        return keyFactory.generatePublic(publicKeySpec);
    }

    @Test
    public void encryptText() {
        String text = "72W9z*uh4tWO";
        String encryptedText = encryptRSA(text);
        System.out.println("Original: " + text + "\nEncrypted: " + encryptedText);
        Assert.assertNotNull(encryptedText);
    }

    @Test
    public void encryptWithAES() throws NoSuchAlgorithmException, NoSuchPaddingException, InvalidAlgorithmParameterException, InvalidKeyException, BadPaddingException, IllegalBlockSizeException {
        String msisdn = "255754711829aaaa";
        byte[] byteIvKey = "ThisIsASecretKey".getBytes(StandardCharsets.UTF_8);
        byte[] byteEncryptionKey = "ThiIsIvParameter".getBytes(StandardCharsets.UTF_8);

        SecretKeySpec keySpec = new SecretKeySpec(byteEncryptionKey, AES_ALGORITHM);
        Cipher cipher = Cipher.getInstance(AES_ENCRYPTION_ALGORITHM);
        IvParameterSpec iv = new IvParameterSpec(byteIvKey);
        cipher.init(Cipher.ENCRYPT_MODE, keySpec, iv);
        String encryptedMsisdn = new String(Base64.getEncoder().encode(cipher.doFinal(msisdn.getBytes())));

        System.out.println("Original: " + msisdn + "\nEncrypted: " + encryptedMsisdn);
        Assert.assertNotNull(encryptedMsisdn);
    }
}