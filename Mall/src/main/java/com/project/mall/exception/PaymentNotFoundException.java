package com.project.mall.exception;

public class PaymentNotFoundException extends RuntimeException{
	public PaymentNotFoundException(String message) {
        super(message);
    }

}
