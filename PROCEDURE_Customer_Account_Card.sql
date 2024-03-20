CREATE OR REPLACE PROCEDURE create_customer_with_account_and_card(
	-- bu prcedure calistirildiginda bir musteri olusturulacak ve musteriye bir hesap ve kart atamasi yapılacaktır 
    p_name VARCHAR(100),
    p_identity_number CHAR(11),
    p_birth_place VARCHAR(50),
    p_birth_date DATE,
    p_risk_limit DECIMAL(15,2),
    p_card_validity_end_date DATE,
    p_ccv_code CHAR(3)
	-- disaridan verilmesi gereken parametreler yukarıda gosterilmektediri
	-- bu parametreler ile PROCEDURE calistirilacak
)
LANGUAGE plpgsql
AS $$
DECLARE
    v_customer_id INTEGER;
    v_account_id INTEGER;
    v_card_number CHAR(16);
	
	-- sonraki adimlarda kullanilmak üzere DECLARE tanimlamalari
BEGIN
    -- ilk olarak bir musteri eklenmesi yapilacak 
	-- eklenen musterinin id degeri RETURNING ifadesi ile v_customer_id degerine atanacak
    INSERT INTO customer(name, identity_number, birth_place, birth_date, risk_limit)
    VALUES (p_name, p_identity_number, p_birth_place, p_birth_date, p_risk_limit)
    RETURNING customer_id INTO v_customer_id;
    
    -- eklenen musteri icin v_customer_id degeri ile beraber bir hesap tanimlanacak
    INSERT INTO account(customer_id, account_name, account_number, iban)
    VALUES (v_customer_id, 'Otomatik Hesap', LPAD((SELECT COUNT(*) FROM account)::text, 20, '0'), -- Bu adımlar ChatGPT'den aldım
            'TR' || LPAD((SELECT COUNT(*) FROM account)::text, 24, '0')) -- Bu adımlar ChatGPT'den aldım
    RETURNING account_id INTO v_account_id;
	-- eklenen hesabin id degeri v_account_id degerine ataniyor buradaki amac bu hesaba bir kart 
	-- tanimlanması icin sonrasinda kullanilması icin 
    
    -- Oluşturulan hesap için bir kart tanimlanmasi yapilacak
    -- tum islemler bir hata olmasi durumuna karsilik bir transaction ile kontrol ediliyor (BEGIN END ifadeleri) 
    SELECT '5200' || LPAD(v_account_id::text, 12, '0') INTO v_card_number FROM account WHERE account_id = v_account_id;
    INSERT INTO card(account_id, card_number, validity_end_date, ccv_code, card_type)
    VALUES (v_account_id, v_card_number, p_card_validity_end_date, p_ccv_code, 'debit');
END;
$$;
