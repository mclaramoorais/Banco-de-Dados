use sakila;

show tables; 

select * from actor;

-- 1. Escreva uma consulta SQL para listar os títulos de todos os filmes na tabela film que tem uma duração (length) superior a 120 minutos.

select * from film where length >120;

-- 2. Escreva uma consulta SQL para encontrar o número total de filmes em cada categoria de classificação (rating) na tabela film.

select rating, count(*) as total_filmes from film group by rating order by total_filmes desc;

-- 3. Escreva uma consulta SQL para encontrar o preço médio de aluguel (rental rate) dos filmes na tabela film.

SELECT AVG(rental_rate) AS preco_medio_a FROM film;

-- 4. Escreva uma consulta SQL para encontrar o filme com o maior custo de substituição (replacement cost) na tabela film.

SELECT title, replacement_cost FROM film WHERE replacement_cost = (select max(replacement_cost) from film);

-- 5. Escreva uma consulta SQL para listar os nomes e sobrenomes dos atores na tabela actor cujo sobrenome come¸ca com a letra ’S’.

SELECT first_name, last_name FROM actor WHERE last_name LIKE 'S%';

-- 6. Escreva uma consulta SQL para encontrar o nÚmero de clientes ativos e inativos na tabela customer.

SELECT ACTIVE, count(*) as total_clientes FROM customer group by active;

-- 7. Escreva uma consulta SQL para listar os tÍtulos dos filmes na tabela filme que contem a palavra ’LOVE’ em qualquer posição do título.

SELECT title FROM film where title like'%love%';

-- 8. Escreva uma consulta SQL para encontrar os 3 primeiros idiomas da tabela language.

SELECT name FROM language ORDER BY language_id LIMIT 3;

-- 9. Escreva uma consulta SQL para encontrar o comprimento (número de caracteres) do título mais longo na tabela film. Pesquise como utilizar a função LENGTH().

SELECT MAX(LENGTH(title)) AS comprimento 
FROM film;

-- 10. Escreva uma consulta SQL para listar os nomes completos dos clientes (concatenando first name e last name com um espaço entre eles) na tabela customer. Pesquise como utilizar a função CONCAT()

SELECT first_name + ' ' + last_name AS f FROM customer;

-- 11. Escreva uma consulta SQL para encontrar o valor total pago por cada cliente na tabela payment. Pesquise como utilizar a clausula GROUP BY.

select customer_id, sum(amount) as total_pago from payment group by customer_id order by total_pago desc;

-- 12. Escreva uma consulta SQL para encontrar a duração média dos filmes para cada classificação (rating) na tabela film. Pesquise como utilizar a função para cálculo de méedia AVG()

select rating, avg(length) as duracao_media from film group by rating order by duracao_media desc;

-- 13. Escreva uma consulta SQL para listar os países na tabela country em ordem alfabética.

select country from country order by country asc;

-- 14. Escreva uma consulta SQL para encontrar o número de cidades em cada país na tabela city.

select country_id, count(*) as total_cidades from city group by country_id order by total_cidades desc;

-- 15. Escreva uma consulta SQL para encontrar o filme mais curto e o mais longo na tabela film. * ERRO

select title, length from film where length = (select min(length) from film) or length = (select max(length) from film);

-- 16. Escreva uma instrução SQL para atualizar o preço de aluguel (rental rate) de todos os filmes na tabela film com classificação ’G’ para 1.99.

UPDATE film
SET rental_rate = 1.99
WHERE rating = 'G';

-- 17. Escreva uma instrução SQL para atualizar o status de ativo (active) para 0 de todos os clientes na tabela customer que não fizeram um aluguel nos últimos 6 meses.

UPDATE customer
SET active = 0
WHERE customer_id NOT IN (
    SELECT DISTINCT customer_id
    FROM rental
    WHERE rental_date >= NOW() - INTERVAL 6 MONTH
);

-- 18. Escreva uma instrução SQL para atualizar a descrição de todos os filmes na tabela film que não tem descrição (NULL) para ’Descrição não disponível’.

update film set description = 'descrição não disponivel' where description is null;

-- 19. Escreva uma instrução SQL para aumentar em 10% o custo de substituição (replacement_cost) de todos os filmes na tabela film com duração superior a 100 minutos.
                                                                                                                                                                                                                                                                                                                       
UPDATE film
SET replacement_cost = replacement_cost * 1.10
WHERE length > 100;

-- 20. Escreva uma instrução SQL para atualizar o sobrenome (last name) de um ator específico na tabela actor (por exemplo, ator com actor id =5) para ’JACKSON’.

update actor set last_name = 'jackson' where actor_id = 5;

-- 21. Escreva uma instrução SQL para atualizar o endereço de e-mail (email) de todos os clientes na tabela customer para o formato ’nome.sobrenome@sakilacustomer.org’.

UPDATE customer
SET email = CONCAT(first_name, '.', last_name, '@sakilacustomer.org');

-- 22. Escreva uma instrução SQL para atualizar a data de devolução (return date) para a data atual em todos os alugueis na tabela rental que ainda não foram devolvidos (onde return date ´e NULL).

UPDATE rental
SET return_date = NOW()
WHERE return_date IS NULL;

-- 23. Escreva uma instrução SQL para atualizar o nome de um idioma específico na tabela language (por exemplo, idioma com language id = 3) para ’Português’.

UPDATE language
SET name = 'Português'
WHERE language_id = 3;

-- 24. Escreva uma instruçãao SQL para atualizar a duração de aluguel (rental duration) para 7 dias de todos os filmes na tabela film com classificação ’PG-13’.

UPDATE film
SET rental_duration = 7
WHERE rating = 'PG-13';

-- 25. Escreva uma instrução SQL para atualizar o nome de uma categoria específica na tabela category (por exemplo, categoria com category id =2) para ’Sci-Fi’.

UPDATE category 
SET name = 'Sci-Fi'
WHERE category_id = 2;

-- 26. Escreva uma instrução SQL para excluir todos os pagamentos na tabela payment com valor inferior a 1.00.

delete from payment where amount < 1.00;

-- 27. Escreva uma instrução SQL para excluir um cliente específico da tabela customer (por exemplo, cliente com customer id = 10).

SELECT * FROM customer WHERE 
customer_id = 10;

-- 28. Escreva uma instrução SQL para excluir todos os filmes da tabela film que tem uma classificação ’NC-17’.

DELETE FROM inventory WHERE
film_id IN (SELECT film_id FROM film WHERE rating = 'NC-17');
DELETE FROM film WHERE rating = 'NC-17';

-- 29. Escreva uma instrução SQL para excluir todos os alugueis na tabela rental que foram devolvidos antes de uma data específica (por exemplo, ’2005-06-01’).

delete from rental where return_date < '2005-06-01';

-- 30. Escreva uma instrução SQL para excluir um ator específico da tabela actor (por exemplo, ator com actor id = 15).

SELECT * FROM actor WHERE
actor_id = 15;
DELETE FROM film_actor WHERE
actor_id = 15;

-- 31. Escreva uma instrução SQL para encontrar o número total de alugueis (rental) por cliente, mostrando apenas os clientes que fizeram mais de 25 alugueis. Para esse exercício pesquise na documentação oficial como utilizar a cláusura HAVING.

select customer_id, count(*) as total_alugueis from rental group by customer_id having count(*) > 25 order by total_alugueis desc;

-- 32. Escreva uma consulta SQL para encontrar a média de duração dos filmes para cada categoria de classificação (rating) e, em seguida, atualize o campo rental duration para ser igual `a média arredondada para cada grupo.

SELECT rating, ROUND(AVG(length)) AS med
FROM film
group by rating;

-- 33. Escreva uma consulta SQL para encontrar o valor total gasto por cada cliente e, em seguida, exclua todos os pagamentos dos clientes que gastaram menos de 50.00 no total.

SELECT customer_id, SUM(amount) AS total
FROM payment 
group by customer_id;

-- 34. Escreva uma consulta SQL para encontrar o comprimento médio do título dos filmes e, em seguida, liste todos os filmes cujo título tem um comprimento maior que a média.

SELECT title
FROM film
WHERE LENGTH(title) > (
    SELECT AVG(LENGTH(title))
    FROM film
);

-- 35. Escreva uma consulta SQL para encontrar os 5 atores que aparecem em mais filmes e, em seguida, atualize seus sobrenomes para incluir o prefixo ’STAR-’.

SELECT actor_id, COUNT(film_id)
AS total_films
FROM film_actor
GROUP BY actor_id
ORDER BY total_films DESC
LIMIT 5;