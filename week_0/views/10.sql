SELECT "english_title" as "Most complex works by Hokusai"
FROM "views"
WHERE "artist" == 'Hokusai'
ORDER BY "entropy" LIMIT 10;
