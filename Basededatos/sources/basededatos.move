module basededatos::basededatos {
    use std::string::{String, utf8};
    use sui::vec_map::{VecMap, Self};
    use sui::object;
    use sui::transfer;
    use sui::tx_context::{Self, TxContext};

    public struct Base has key, store {
        id: UID,
        nombre: String,
        datos: VecMap<u8, Persona>
    }

    public struct Persona has store, drop, copy {
        nombre_persona: String,
        edad: u8,
        informacion: vector<String>,
        tipo: Tipo,
    }

    public enum Tipo has store, drop, copy {
        normal(Normal),
        plus(Plus),
    }

    public struct Normal has store, drop, copy {
        descuento: u8
    }

    public struct Plus has store, drop, copy {
        descuento: u8
    }

    #[error]
    const ID_REPETIDO: vector<u8> = b"ERROR: EL ID YA EXISTE, INTENTA CON OTRO";
    #[error]
    const ID_NO_EXISTE: vector<u8> = b"ERROR: EL ID NO EXISTE";

    public fun crear_base_de_datos(nombre: String, ctx: &mut TxContext) {
        let base_de_datos = Base {
            id: object::new(ctx),
            nombre,
            datos: vec_map::empty()
        };

        transfer::transfer(base_de_datos, tx_context::sender(ctx));
    }

    public fun agregar_persona(base_de_datos: &mut Base, nombre: String, edad: u8, id: u8) {
        assert!(!base_de_datos.datos.contains(&id), ID_REPETIDO);

        let persona = Persona {
            nombre_persona: nombre,
            edad,
            informacion: vector[],
            tipo: Tipo::normal(Normal { descuento: 35 })
        };

        base_de_datos.datos.insert(id, persona);
    }

    public fun agregar_informacion(base_de_datos: &mut Base, id: u8, info: String) {
        assert!(base_de_datos.datos.contains(&id), ID_NO_EXISTE);

        let mut persona = base_de_datos.datos.get_mut(&id);
        persona.informacion.push_back(info);
    }

    public fun cambiar_a_plus(base_de_datos: &mut Base, id: u8) {
        assert!(base_de_datos.datos.contains(&id), ID_NO_EXISTE);
        let mut persona = base_de_datos.datos.get_mut(&id);

        persona.tipo = Tipo::plus(Plus { descuento: 50 });
    }

    public fun cambiar_a_normal(base_de_datos: &mut Base, id: u8) {
        assert!(base_de_datos.datos.contains(&id), ID_NO_EXISTE);
        let mut persona = base_de_datos.datos.get_mut(&id);

        persona.tipo = Tipo::normal(Normal { descuento: 5 });
    }

    public fun obtener_descuento(base_de_datos: &mut Base, id: u8): u8 {
        assert!(base_de_datos.datos.contains(&id), ID_NO_EXISTE);
        let mut persona = base_de_datos.datos.get_mut(&id);
        let tipo = persona.tipo;

        match (tipo) {clea
            Tipo::normal(Normal { descuento }) => descuento,
            Tipo::plus(Plus { descuento }) => descuento,
        }
    }

    public fun eliminar_persona(base_de_datos: &mut Base, id: u8) {
        assert!(base_de_datos.datos.contains(&id), ID_NO_EXISTE);
        base_de_datos.datos.remove(&id);
    }
}

