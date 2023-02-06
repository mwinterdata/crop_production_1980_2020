WITH tonne_ha AS
(SELECT *
FROM CropProduction.dbo.crop_production
WHERE MEASURE = 'TONNE_HA'),

thnd_tonne AS
(SELECT *
FROM CropProduction.dbo.crop_production
WHERE MEASURE = 'THND_TONNE'),

thnd_ha AS 
(SELECT *
FROM CropProduction.dbo.crop_production
WHERE MEASURE = 'THND_HA')


SELECT country_codes.continent_name AS continent,
country_codes.Country_Name AS country_full_name,
tonne_ha.LOCATION AS country_code,
tonne_ha.SUBJECT AS crop,
tonne_ha.TIME as year, 
ROUND(tonne_ha.Value, 6) AS tonne_per_hectare,
ROUND(thnd_tonne.Value, 0) AS harvest_in_thousand_tonnes,
ROUND(thnd_ha.Value, 0) AS hectares_seeded
INTO CropProduction.dbo.crop_production_sorted
FROM tonne_ha
LEFT JOIN thnd_tonne 
ON tonne_ha.LOCATION = thnd_tonne.LOCATION
AND tonne_ha.SUBJECT = thnd_tonne.SUBJECT
AND tonne_ha.TIME = thnd_tonne.TIME
LEFT JOIN thnd_ha
ON tonne_ha.LOCATION = thnd_ha.LOCATION
AND tonne_ha.SUBJECT = thnd_ha.SUBJECT
AND tonne_ha.TIME = thnd_ha.TIME
LEFT JOIN CropProduction.dbo.country_and_content_codes_list as country_codes
ON tonne_ha.LOCATION = country_codes.Three_Letter_Country_Code
WHERE country_codes.continent_name IS NOT NULL 

