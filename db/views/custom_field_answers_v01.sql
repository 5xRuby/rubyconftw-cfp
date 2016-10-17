SELECT
  p.id, c.id AS custom_field_id, c.name, c.required, c.activity_id, p.user_id, jsonb_extract_path(ans, key) AS answer
FROM custom_fields AS c
JOIN
  (SELECT id, user_id, jsonb_object_keys(answer_of_custom_fields) AS key,
      		 answer_of_custom_fields as ans FROM papers
  ) AS p
ON c.id = p.key::int
