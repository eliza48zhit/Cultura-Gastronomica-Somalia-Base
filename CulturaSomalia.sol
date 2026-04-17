// SPDX-License-Identifier: MIT
pragma solidity ^0.8.20;

/**
 * @title CulturaSomalia
 * @dev Registro de la arquitectura de aromas y absorcion de granos.
 * Serie: Sabores de Africa (31/54)
 */
contract CulturaSomalia {

    struct Plato {
        string nombre;
        string ingredientes;
        string preparacion;
        uint256 indiceFragancia;    // Nivel de especias Xawaash (1-10)
        uint256 capilaridadGrano;   // Capacidad de absorcion de caldo (1-100)
        bool usaCarneConHueso;      // Validador de extraccion de colageno
        uint256 likes;
        uint256 dislikes;
    }

    mapping(uint256 => Plato) public registroCulinario;
    uint256 public totalRegistros;
    address public owner;

    constructor() {
        owner = msg.sender;
        // Inauguramos con el Bariis Iskukaris (Ingenieria de Aromas)
        registrarPlato(
            "Bariis Iskukaris", 
            "Arroz basmati, Xawaash (comino, cilantro, cardamomo, canela), carne de cabra.",
            "Coccion del arroz en un caldo rico en grasas y especias, permitiendo una hidratacion profunda del grano.",
            10, 
            95, 
            true
        );
    }

    function registrarPlato(
        string memory _nombre, 
        string memory _ingredientes,
        string memory _preparacion,
        uint256 _fragancia, 
        uint256 _capilaridad,
        bool _hueso
    ) public {
        require(bytes(_nombre).length > 0, "Nombre requerido");
        require(_fragancia <= 10, "Escala de fragancia excedida");

        totalRegistros++;
        registroCulinario[totalRegistros] = Plato({
            nombre: _nombre,
            ingredientes: _ingredientes,
            preparacion: _preparacion,
            indiceFragancia: _fragancia,
            capilaridadGrano: _capilaridad,
            usaCarneConHueso: _hueso,
            likes: 0,
            dislikes: 0
        });
    }

    function darLike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].likes++;
    }

    function darDislike(uint256 _id) public {
        require(_id > 0 && _id <= totalRegistros, "ID invalido");
        registroCulinario[_id].dislikes++;
    }

    function consultarPlato(uint256 _id) public view returns (
        string memory nombre,
        uint256 fragancia,
        uint256 capilaridad,
        bool hueso,
        uint256 likes
    ) {
        require(_id > 0 && _id <= totalRegistros, "ID inexistente");
        Plato storage p = registroCulinario[_id];
        return (p.nombre, p.indiceFragancia, p.capilaridadGrano, p.usaCarneConHueso, p.likes);
    }
}
