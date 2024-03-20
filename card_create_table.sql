CREATE TABLE card (
    card_id SERIAL PRIMARY KEY,
    account_id INTEGER NULL,
    customer_id INTEGER NULL,
    card_number CHAR(16) UNIQUE NOT NULL,
    validity_end_date DATE NOT NULL,
    ccv_code CHAR(3) NOT NULL,
    card_type VARCHAR(20) NOT NULL, -- kartin hangi tipte oldugunu belirtmek icin 
    active BOOLEAN DEFAULT TRUE,
	--kart kullanimda mi degil mi bunun icin bir parametre
    deleted BOOLEAN DEFAULT FALSE,
	-- soft delete icin bir parametre 
    deleted_at TIMESTAMP WITH TIME ZONE,
    FOREIGN KEY (account_id) REFERENCES account(account_id),
    FOREIGN KEY (customer_id) REFERENCES customer(customer_id)
	-- kartin hangi hesaba ve hangi musteriye ait oldugu ile ilgili bir iliskilendirme PK_FK
);
