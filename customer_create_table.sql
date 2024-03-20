CREATE TABLE customer (
    customer_id SERIAL PRIMARY KEY,
	-- customer_id otomatik artan(SERIAL) ve PK olmalı ki hesaplar ve kartlar ile iliskilendirilsin
    name VARCHAR(100) NOT NULL,
    identity_number CHAR(11) UNIQUE NOT NULL,
    birth_place VARCHAR(50) NOT NULL,
    birth_date DATE NOT NULL,
    risk_limit DECIMAL(15,2) DEFAULT 10000.00,
    deleted BOOLEAN DEFAULT FALSE,
    deleted_at TIMESTAMP WITH TIME ZONE
	--silinmiş bir kaydın ne zaman silindiğini belirtmek için kullanılır
	--Bu türbir tarih ve saat bilgisi ile birlikte zaman dilimini de içerir
);
