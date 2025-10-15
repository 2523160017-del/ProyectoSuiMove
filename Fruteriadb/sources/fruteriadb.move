module fruteriadb::fruteriadb {
    use std::string::String;
    use sui::vec_map::{VecMap, Self};


    /// ------------------------------------------------------------------------
    /// Estructuras principales
    /// ------------------------------------------------------------------------

    public struct Base has key, store {
        id: UID,
        nombre_base: String,
        datos: VecMap<u8, Fruta>,
    }

    public struct Fruta has store, drop, copy {
        nombre_fruta: String,
        cantidad: u8,
    }

    /// ------------------------------------------------------------------------
    /// Errores
    /// ------------------------------------------------------------------------
    #[error]
    const ID_REPETIDO: vector<u8> = b"ERROR: El ID ya existe, intenta con otro";
    #[error]
    const ID_NO_EXISTE: vector<u8> = b"ERROR: El ID no existe";

    /// ------------------------------------------------------------------------
    /// CRUD COMPLETO
    /// ------------------------------------------------------------------------

    // CREAR base de datos
    public fun crear_base(nombre: String, ctx: &mut TxContext) {
        let base = Base {
            id: object::new(ctx),
            nombre_base: nombre,
            datos: vec_map::empty(),
        };
        transfer::transfer(base, tx_context::sender(ctx));
    }

    // INSERTAR fruta
    public fun agregar_fruta(base: &mut Base, id: u8, nombre: String, cantidad: u8) {
        assert!(!base.datos.contains(&id), ID_REPETIDO);

        let fruta = Fruta {
            nombre_fruta: nombre,
            cantidad,
        };

        base.datos.insert(id, fruta);
    }

    // LEER fruta
  public fun obtener_fruta(base: &Base, id: u8): Fruta {
    assert!(base.datos.contains(&id), ID_NO_EXISTE);
    *base.datos.get(&id)
}

    // EDITAR fruta
    public fun editar_fruta(base: &mut Base, id: u8, nuevo_nombre: String, nueva_cantidad: u8) {
        assert!(base.datos.contains(&id), ID_NO_EXISTE);
        let mut fruta = base.datos.get_mut(&id);
        fruta.nombre_fruta = nuevo_nombre;
        fruta.cantidad = nueva_cantidad;
    }

    // ELIMINAR fruta
    public fun eliminar_fruta(base: &mut Base, id: u8) {
        assert!(base.datos.contains(&id), ID_NO_EXISTE);
        base.datos.remove(&id);
    }
}

