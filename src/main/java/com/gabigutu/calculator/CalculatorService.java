package com.gabigutu.calculator;

import java.io.IOException;

public class CalculatorService {

    public float sum(float a, float b) {
        return a + b;
    }

    public float difference(float a, float b) {
        return a - b;
    }

    public float multiply(float a, float b) {
        return a * b;
    }

    public float divide(float a, float b) {
        return a / b;
    }

    public float operation(float a, float b, char operation) throws IOException {
        switch (operation) {
            case '+':
                return sum(a, b);
            case '-':
                return difference(a, b);
            case '*':
                return multiply(a, b);
            case ':':
                return divide(a, b);
            default:
                throw new IOException("Operation Not Supported!");
        }
    }
}

