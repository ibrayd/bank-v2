CREATE TABLE transaction (
	
	--islemleri takip etmek icin bir tablo 
    transaction_id SERIAL PRIMARY KEY,
    card_id INTEGER NOT NULL,
    transaction_type VARCHAR(20) NOT NULL, 
    amount DECIMAL(15,2) NOT NULL,
    description VARCHAR(100),
    transaction_date TIMESTAMP WITH TIME ZONE DEFAULT NOW(),
    deleted BOOLEAN DEFAULT FALSE,
	--islemi silmek icin bir soft_delete
    deleted_at TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (card_id) REFERENCES card(card_id)
	-- islemin hangi karta ait oldugunu belirtmek icin cart tablosundaki card id ile iliskilendirme 
);
