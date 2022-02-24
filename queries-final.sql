CREATE TABLE `cap03`.`TB_DADOS` (
  `classe` VARCHAR(100) NULL,
  `idade` VARCHAR(45) NULL,
  `menopausa` VARCHAR(45) NULL,
  `tamanho_tumor` VARCHAR(45) NULL,
  `inv_nodes` VARCHAR(45) NULL,
  `node_caps` VARCHAR(3) NULL,
  `deg_malig` INT NULL,
  `seio` VARCHAR(5) NULL,
  `quadrante` VARCHAR(10) NULL,
  `irradiando` VARCHAR(3) NULL);

CREATE TABLE cap03.TB_DADOS_FINAL
AS
SELECT 
	CASE
		WHEN classe = 'no-recurrence-events' THEN 0
        WHEN classe = 'recurrence-events' THEN 1
	END AS classe, 
    idade, 
    CASE
		WHEN menopausa = 'ge40' THEN 1
		WHEN menopausa = 'lt40' THEN 2
        WHEN menopausa = 'premeno' THEN 3
	END AS menopausa, 
    CASE
		WHEN tamanho_tumor = '0-4' OR tamanho_tumor = '5-9' THEN 'Muito Pequeno'
        WHEN tamanho_tumor = '10-14' OR tamanho_tumor = '15-19' THEN 'Pequeno'
        WHEN tamanho_tumor = '20-24' OR tamanho_tumor = '25-29' THEN 'Medio'
        WHEN tamanho_tumor = '30-34' OR tamanho_tumor = '35-39' THEN 'Grande'
        WHEN tamanho_tumor = '40-44' OR tamanho_tumor = '45-49' THEN 'Muito Grande'
        WHEN tamanho_tumor = '50-54' OR tamanho_tumor = '55-59' THEN 'Urgente tratamento'
	END as tamanho_tumor, 
    
    
	CONCAT(inv_nodes, '-Q', (SELECT 
									CASE 
										WHEN quadrante = 'left_low' THEN 1 
										WHEN quadrante = 'right_up' THEN 2 
										WHEN quadrante = 'left_up' THEN 3
										WHEN quadrante = 'right_low' THEN 4
										WHEN quadrante = 'central' THEN 5
										ELSE 0
									END AS quadrante_transformed)
							 ) AS posicao_tumor, 
    
    CASE
		WHEN node_caps = 'no' THEN 0
        WHEN node_caps = 'yes' THEN 1
        ELSE 2
	END AS node_caps,
    CASE WHEN deg_malig = 1 THEN 1 ELSE 0 END AS deg_malig_1,
    CASE WHEN deg_malig = 2 THEN 1 ELSE 0 END AS deg_malig_2,
    CASE WHEN deg_malig = 3 THEN 1 ELSE 0 END AS deg_malig_3,
    CASE
		WHEN seio = 'left' THEN 'E'
        WHEN seio = 'right' THEN 'D'
	END AS seio,
    CASE
		WHEN irradiando = 'no' THEN 0
        WHEN irradiando = 'yes' THEN 1
	END AS irradiando
FROM cap03.TB_DADOS;