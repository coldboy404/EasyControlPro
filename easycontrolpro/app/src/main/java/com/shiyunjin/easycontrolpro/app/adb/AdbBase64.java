package com.shiyunjin.easycontrolpro.app.adb;

public interface AdbBase64 {
  String encodeToString(byte[] data);

  byte[] decode(byte[] data);
}
