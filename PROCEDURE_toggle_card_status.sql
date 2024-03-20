CREATE OR REPLACE PROCEDURE toggle_card_status(
	-- toggle_card_status adinda bir PROCEDURE olusturulacak 
	-- bu PROCEDURE hangi card_id degerinin aktif veya pasif edileceğine dair bir TRUE FALSE degeri verilecek
    p_card_id INTEGER,
    p_active BOOLEAN
)
LANGUAGE plpgsql
AS $$
BEGIN
-- card tablosundaki 
-- parametreye verilen p_card_id degerinin card tablosundaki card_id sütunundaki deger ile eslesen kayıtta 
-- baslangicta verilen p_active degeri tablodaki active degeri ile guncellenecek 
    UPDATE card
    SET active = p_active
    WHERE card_id = p_card_id;
END;
$$;
