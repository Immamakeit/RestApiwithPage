package com.gyuha.user2.consts;

public enum ResultCode {

    SUCCESS(0),
    DATA_NOT_FOUND(-1),
    VIOLATED_INTEGRITY_DB(-2),
    INVALID_PASSWORD(-3),
    NO_SUCH_USER(-4),
    UNKNOWN_EXCEPTION(-99);

    private final int value;

    ResultCode(int value) {
        this.value = value;
    }

    public int value() {
        return value;
    }
}
