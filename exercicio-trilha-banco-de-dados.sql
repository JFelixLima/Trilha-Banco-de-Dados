-- Criação tabela de livros para o primeiro exercício 
CREATE TABLE LIVRARIA
(
    livro_id SERIAL PRIMARY KEY, 
    nome VARCHAR(255),
    ano INTEGER,
    maximo_tempo_reserva INTEGER,
    prateleira INTEGER
)

-- Populando a tabela 
INSERT INTO LIVRARIA (nome, ano, maximo_tempo_reserva, prateleira) VALUES ('Senhor dos Anéis', 1954, 12, 23), 
('Harry Potter e a Pedra Filosofal', 1997, 9, 23),
('O Hobbit', 1937, 18, 26),
('Duna', 1984, 5, 26);

-- Consultando dados
SELECT * FROM LIVRARIA;

-- Exercício 1 
SELECT livro_id, nome, maximo_tempo_reserva 
FROM LIVRARIA
WHERE maximo_tempo_reserva > (
    SELECT AVG(maximo_tempo_reserva)
    FROM LIVRARIA 
    GROUP BY prateleira
    LIMIT 1
) 

-- EXERCÍCIO 1 FINALIZADO -- 

-- criando tabelas MENTORES,POSTS e CURTIDAS para o exercício 2.

-- Criando tabela mentores
CREATE TABLE MENTORES(
    mentor_id SERIAL PRIMARY KEY,
    nome VARCHAR(255),
    sala_de_aula VARCHAR(255)
)


-- Criando tabela posts fazendo a associação com a tabela mentores.
CREATE TABLE posts (
    post_id SERIAL PRIMARY KEY,
    mentor_id SERIAL,
    descricao VARCHAR(255),
    FOREIGN KEY (mentor_id) REFERENCES MENTORES (mentor_id)
);

-- Criando tabela curtidas com associações com tabela MENTORES e POSTS.
CREATE TABLE CURTIDAS(
    mentor_id SERIAL,
    post_id SERIAL,
    
    PRIMARY KEY (mentor_id, post_id),
    FOREIGN KEY (mentor_id) REFERENCES MENTORES (mentor_id),
    FOREIGN KEY (post_id) REFERENCES POSTS (post_id)
)

-- POPULANDO TABELAS

-- MENTORES
INSERT INTO MENTORES (nome, sala_de_aula) VALUES ('Warren Buffett', 'Sala de Aula Torvalds'), 
('Steven Spielberg', 'Sala de Aula Gates'), 
('Socrates', 'Sala de Aula Jobs');

-- POSTS
INSERT INTO POSTS (mentor_id, descricao) VALUES (1, 'Post 01'), (1, 'Post 02'), (3, 'Post 03');

--CURTIDAS
INSERT INTO CURTIDAS (mentor_id, post_id) VALUES (1, 1), (3,2),(3,3);

-- EXERCÍCIO 2.1
SELECT MENTORES.nome, COUNT(CURTIDAS.mentor_id) 
    FROM MENTORES 
    INNER JOIN CURTIDAS ON CURTIDAS.mentor_id = MENTORES.mentor_id 
    GROUP BY 1 
    ORDER BY 1
    
-- EXERCÍCIO 2.2 
SELECT MENTORES.sala_de_aula, CURTIDAS.post_id 
    FROM MENTORES 
    INNER JOIN CURTIDAS ON CURTIDAS.mentor_id = MENTORES.mentor_id 
    GROUP BY 1, 2 
    ORDER BY 2
    
-- EXERCÍCIO 2.3
SELECT MENTORES.sala_de_aula, Round(AVG(curtidas.post_id),1)
FROM MENTORES 
INNER JOIN CURTIDAS ON CURTIDAS.mentor_id = MENTORES.mentor_id 
GROUP BY MENTORES.sala_de_aula

