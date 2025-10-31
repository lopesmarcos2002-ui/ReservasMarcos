-- TABELA 1: Tipos de Quartos (Armazena a descrição e preço)
CREATE TABLE tipos_quarto (
    id INT AUTO_INCREMENT PRIMARY KEY,
    nome_tipo VARCHAR(100) NOT NULL,
    descricao TEXT,
    capacidade_adultos INT NOT NULL,
    capacidade_criancas INT DEFAULT 0,
    preco_diaria DECIMAL(10, 2) NOT NULL -- Preço base
);

-- TABELA 2: Quartos Individuais (Para saber qual quarto físico está ocupado)
CREATE TABLE quartos (
    id INT AUTO_INCREMENT PRIMARY KEY,
    numero_quarto VARCHAR(10) NOT NULL UNIQUE,
    id_tipo_quarto INT,
    FOREIGN KEY (id_tipo_quarto) REFERENCES tipos_quarto(id)
);

-- TABELA 3: Reservas (Ocupação das datas)
CREATE TABLE reservas (
    id INT AUTO_INCREMENT PRIMARY KEY,
    id_quarto INT,
    nome_hospede VARCHAR(150) NOT NULL,
    email_hospede VARCHAR(150) NOT NULL,
    data_checkin DATE NOT NULL,
    data_checkout DATE NOT NULL,
    valor_total DECIMAL(10, 2) NOT NULL,
    status_reserva ENUM('Confirmada', 'Pendente', 'Cancelada') DEFAULT 'Pendente',
    data_reserva TIMESTAMP DEFAULT CURRENT_TIMESTAMP,
    FOREIGN KEY (id_quarto) REFERENCES quartos(id)
);

-- INSERÇÃO DE DADOS BÁSICOS (Exemplo)

-- Inserindo tipos de quartos
INSERT INTO tipos_quarto (nome_tipo, descricao, capacidade_adultos, preco_diaria) VALUES
('Standard', 'Quarto confortável com cama de casal.', 2, 150.00),
('Luxo', 'Suíte espaçosa com vista para o mar e banheira.', 2, 350.00),
('Familiar', 'Dois quartos conectados para famílias.', 4, 450.00);

-- Inserindo quartos físicos
INSERT INTO quartos (numero_quarto, id_tipo_quarto) VALUES
('101', 1), ('102', 1), ('103', 1), -- Quartos Standard
('201', 2), ('202', 2), -- Quartos Luxo
('301', 3); -- Quarto Familiar
-- Exemplo de consulta para verificar a disponibilidade de um tipo de quarto (id_tipo_quarto = 1)
-- entre as datas '2025-11-20' (checkin) e '2025-11-25' (checkout)

SELECT COUNT(t1.id) 
FROM quartos AS t1 
WHERE t1.id_tipo_quarto = 1
AND t1.id NOT IN (
    SELECT DISTINCT id_quarto
    FROM reservas 
    WHERE 
        (data_checkin < '2025-11-25' AND data_checkout > '2025-11-20') -- Verifica a sobreposição de datas
        AND status_reserva = 'Confirmada'
);

-- Se o resultado for > 0, o quarto está disponível para reserva.