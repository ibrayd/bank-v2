-- Önce tetikleyici fonksiyonunu tanımlayın
CREATE OR REPLACE FUNCTION update_account_balance()
RETURNS TRIGGER AS $$
BEGIN
    -- İşlem tipine göre hesap bakiyesini güncelle
    IF NEW.transaction_type = 'deposit' THEN
        UPDATE account
        SET balance = balance + NEW.amount
        WHERE account_id = NEW.account_id;
    ELSIF NEW.transaction_type = 'withdraw' THEN
        UPDATE account
        SET balance = balance - NEW.amount
        WHERE account_id = NEW.account_id;
    END IF;
    RETURN NEW;
END;
$$ LANGUAGE plpgsql;

-- Ardından tetikleyiciyi oluşturun
CREATE TRIGGER trigger_update_balance
AFTER INSERT ON transaction
FOR EACH ROW
EXECUTE FUNCTION update_account_balance();
