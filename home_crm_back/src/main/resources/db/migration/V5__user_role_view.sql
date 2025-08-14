CREATE OR REPLACE VIEW user_role_view AS
SELECT u.id                                                    AS user_id,
       org.id                                                  AS organization_id,
       (SELECT role.id FROM role WHERE role.name = 'Владелец') AS role_id
FROM users u
         INNER JOIN organization org ON u.id = org.owner_id
UNION ALL
SELECT u.id   AS user_id,
       org.id AS organization_id,
       r.id   AS role_id
FROM users u
         INNER JOIN employee emp ON u.id = emp.user_id
         INNER JOIN organization org ON emp.organization_id = org.id
         INNER JOIN role r ON emp.role_id = r.id;