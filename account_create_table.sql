CREATE TABLE account (
    account_id SERIAL PRIMARY KEY,
    customer_id INTEGER NOT NULL,
	-- her hesabin bir musteri id degeri olmali
	-- fakat bu musteri id degeri musteriler tablosu ile iliskili olmalidir
    account_name VARCHAR(50) NOT NULL,
    account_number CHAR(20) UNIQUE NOT NULL,
    iban CHAR(26) UNIQUE NOT NULL,
    opening_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP WITH TIME ZONE,
    -- soft delete islemi icin bir parametre
    balance DECIMAL(15,2) DEFAULT 0.00,
    -- hesap bakiyesi için bir parametre
	
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	-- customer_id degerini customer tablosundaki customer_id degeri ile iliskilendirilecek
);
