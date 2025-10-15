module automoviles::automoviles {
    use std::debug::print;
    use std::string::{utf8};
    const NUMERO: u8 = 100;
    

    public fun suma(x:u8) {
        // let mut numero = 50u16;
        // let entrada: u16 = x as u16;
        // print(&(utf8(b"Suma:")));
        // numero = numero + entrada;
        // print(&numero);

        // print(&(utf8(b"Resta:")));
        // numero = numero - entrada;
        // print(&numero);

        // print(&(utf8(b"Multiplicacion:")));
        // numero = numero * entrada;
        // print(&numero);

        // print(&(utf8(b"Division:")));
        // numero = numero / entrada;
        // print(&numero);

        // print(&(utf8(b"Modulo:")));
        // numero = numero % entrada;
        // print(&numero);

        // let verdadero: bool = true;
        // let falso: bool = false;

        // print(&(verdadero && falso)); // AND
        // print(&(verdadero || falso)); // OR
        // print(&(!verdadero)); // NOT
        // print(&(!falso)); // NOT
        // print(&(x == NUMERO));
        // print(&(x != NUMERO));
        // print(&(x > NUMERO));
        // print(&(x < NUMERO));
        // print(&(x >= NUMERO));
        // print(&(x <= NUMERO));

        // if(x == NUMERO){
        //     print(&(utf8(b"NUMERO 100")));
        // } else if (x < NUMERO) {
        //     print(&(utf8(b"NUMERO MENOR A 100")));

        // } else {
        //     print(&(utf8(b"NUMERO MAYOR A 100")));
        // };

        // print(&(utf8(b"IF TERMINADO")));

        let mut contador: u8 = 0;
        // while(contador < x) {
        //     print(&contador);
        //     contador = contador + 1;
        // };

        // print(&(utf8(b"WHILE TERMINADO")));

        loop {
            contador = contador + 1;
            if (contador == x) {
                break
            } else if ((contador % 2) == 0) {
                print(&(utf8(b"NUMERO PAR")));
                print(&contador);
                continue
            };
            print(&(utf8(b"NUMERO IMPAR")));

        }

    }



    #[test]
    public fun testing() {
        suma(10);
    }
}