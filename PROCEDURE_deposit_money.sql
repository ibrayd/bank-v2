CREATE OR REPLACE PROCEDURE deposit_money(
    p_card_id INTEGER,
    p_amount DECIMAL(15,2),
    p_description VARCHAR(100)
)
LANGUAGE plpgsql
AS $$
BEGIN
    INSERT INTO transaction(card_id, transaction_type, amount, description, transaction_date)
    VALUES (p_card_id, 'deposit', p_amount, p_description, NOW());
    
    -- Hesap bakiyesi güncellemesi için tetikleyici(TRIGGER) tarafından yapılacak. Trıgger_update_account_balance dosyası
END;
$$;
