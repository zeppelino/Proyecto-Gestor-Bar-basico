PGDMP      6                }            BAR2025    17.4    17.4 :    G           0    0    ENCODING    ENCODING        SET client_encoding = 'UTF8';
                           false            H           0    0 
   STDSTRINGS 
   STDSTRINGS     (   SET standard_conforming_strings = 'on';
                           false            I           0    0 
   SEARCHPATH 
   SEARCHPATH     8   SELECT pg_catalog.set_config('search_path', '', false);
                           false            J           1262    16389    BAR2025    DATABASE     o   CREATE DATABASE "BAR2025" WITH TEMPLATE = template0 ENCODING = 'UTF8' LOCALE_PROVIDER = libc LOCALE = 'es-MX';
    DROP DATABASE "BAR2025";
                     postgres    false            �            1259    16395    Detalle    TABLE     t   CREATE TABLE public."Detalle" (
    numero_venta integer,
    id_producto integer,
    cantidad_vendidad integer
);
    DROP TABLE public."Detalle";
       public         heap r       postgres    false            �            1259    16398    Producto    TABLE     �   CREATE TABLE public."Producto" (
    id_producto integer NOT NULL,
    nombre_producto character varying,
    cantidad_stock integer,
    costo_unitario double precision,
    delete date,
    limite_alarmable integer,
    id_categoria integer
);
    DROP TABLE public."Producto";
       public         heap r       postgres    false            �            1259    16403    Producto_id_producto_seq    SEQUENCE     �   ALTER TABLE public."Producto" ALTER COLUMN id_producto ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Producto_id_producto_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    218            �            1259    16404    Usuario    TABLE     �   CREATE TABLE public."Usuario" (
    dni integer NOT NULL,
    nombre character varying,
    tipo character varying,
    fecha_nacimiento date,
    clave character varying,
    delete date
);
    DROP TABLE public."Usuario";
       public         heap r       postgres    false            �            1259    16409    Ventas    TABLE     �   CREATE TABLE public."Ventas" (
    numero_venta integer NOT NULL,
    fecha date,
    forma_pago character varying,
    dni integer
);
    DROP TABLE public."Ventas";
       public         heap r       postgres    false            �            1259    16414    Ventas_numero_venta_seq    SEQUENCE     �   ALTER TABLE public."Ventas" ALTER COLUMN numero_venta ADD GENERATED ALWAYS AS IDENTITY (
    SEQUENCE NAME public."Ventas_numero_venta_seq"
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1
);
            public               postgres    false    221            �            1259    16535 
   categorias    TABLE     u   CREATE TABLE public.categorias (
    id_categoria integer NOT NULL,
    categoria character varying(100) NOT NULL
);
    DROP TABLE public.categorias;
       public         heap r       postgres    false            �            1259    16534    categorias_id_categoria_seq    SEQUENCE     �   CREATE SEQUENCE public.categorias_id_categoria_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 2   DROP SEQUENCE public.categorias_id_categoria_seq;
       public               postgres    false    231            K           0    0    categorias_id_categoria_seq    SEQUENCE OWNED BY     [   ALTER SEQUENCE public.categorias_id_categoria_seq OWNED BY public.categorias.id_categoria;
          public               postgres    false    230            �            1259    16490    detalle_venta    TABLE     u  CREATE TABLE public.detalle_venta (
    id_detalle integer NOT NULL,
    id_venta integer NOT NULL,
    id_producto integer NOT NULL,
    cantidad integer NOT NULL,
    precio_unitario numeric(10,2) NOT NULL,
    CONSTRAINT detalle_venta_cantidad_check CHECK ((cantidad > 0)),
    CONSTRAINT detalle_venta_precio_unitario_check CHECK ((precio_unitario >= (0)::numeric))
);
 !   DROP TABLE public.detalle_venta;
       public         heap r       postgres    false            �            1259    16489    detalle_venta_id_detalle_seq    SEQUENCE     �   CREATE SEQUENCE public.detalle_venta_id_detalle_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 3   DROP SEQUENCE public.detalle_venta_id_detalle_seq;
       public               postgres    false    227            L           0    0    detalle_venta_id_detalle_seq    SEQUENCE OWNED BY     ]   ALTER SEQUENCE public.detalle_venta_id_detalle_seq OWNED BY public.detalle_venta.id_detalle;
          public               postgres    false    226            �            1259    16517 	   productos    TABLE     C  CREATE TABLE public.productos (
    id integer NOT NULL,
    id_producto character varying(20) NOT NULL,
    nombre_producto character varying(100) NOT NULL,
    cantidad_stock integer NOT NULL,
    costo_unitario real NOT NULL,
    limite_alarmante integer NOT NULL,
    id_categoria integer NOT NULL,
    estado character varying(20) DEFAULT 'disponible'::character varying,
    CONSTRAINT productos_cantidad_stock_check CHECK ((cantidad_stock >= 0)),
    CONSTRAINT productos_costo_unitario_check CHECK ((costo_unitario >= ((0)::numeric)::double precision)),
    CONSTRAINT productos_estado_check CHECK (((estado)::text = ANY ((ARRAY['disponible'::character varying, 'no disponible'::character varying, 'stock bajo'::character varying])::text[]))),
    CONSTRAINT productos_limite_alarmante_check CHECK ((limite_alarmante >= 0))
);
    DROP TABLE public.productos;
       public         heap r       postgres    false            �            1259    16516    productos_id_seq    SEQUENCE     �   CREATE SEQUENCE public.productos_id_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 '   DROP SEQUENCE public.productos_id_seq;
       public               postgres    false    229            M           0    0    productos_id_seq    SEQUENCE OWNED BY     E   ALTER SEQUENCE public.productos_id_seq OWNED BY public.productos.id;
          public               postgres    false    228            �            1259    16443    usuarios    TABLE     �  CREATE TABLE public.usuarios (
    dni_usuario character varying(20) NOT NULL,
    nombre character varying(100) NOT NULL,
    tipo_usuario character varying(20) NOT NULL,
    fecha_nacimiento date NOT NULL,
    clave text NOT NULL,
    estado character varying(20) DEFAULT 'activo'::character varying NOT NULL,
    CONSTRAINT chk_estado_usuario CHECK (((estado)::text = ANY ((ARRAY['activo'::character varying, 'inactivo'::character varying, 'suspendido'::character varying])::text[]))),
    CONSTRAINT usuarios_tipo_usuario_check CHECK (((tipo_usuario)::text = ANY ((ARRAY['camarero'::character varying, 'vendedor'::character varying, 'administrador'::character varying, 'cajero'::character varying])::text[])))
);
    DROP TABLE public.usuarios;
       public         heap r       postgres    false            �            1259    16477    ventas    TABLE     3  CREATE TABLE public.ventas (
    id_venta integer NOT NULL,
    dni_usuario character varying(20) NOT NULL,
    valor_total numeric(10,2) NOT NULL,
    fecha_venta date NOT NULL,
    forma_pago character varying(50) NOT NULL,
    CONSTRAINT ventas_valor_total_check CHECK ((valor_total >= (0)::numeric))
);
    DROP TABLE public.ventas;
       public         heap r       postgres    false            �            1259    16476    ventas_id_venta_seq    SEQUENCE     �   CREATE SEQUENCE public.ventas_id_venta_seq
    AS integer
    START WITH 1
    INCREMENT BY 1
    NO MINVALUE
    NO MAXVALUE
    CACHE 1;
 *   DROP SEQUENCE public.ventas_id_venta_seq;
       public               postgres    false    225            N           0    0    ventas_id_venta_seq    SEQUENCE OWNED BY     K   ALTER SEQUENCE public.ventas_id_venta_seq OWNED BY public.ventas.id_venta;
          public               postgres    false    224            �           2604    16538    categorias id_categoria    DEFAULT     �   ALTER TABLE ONLY public.categorias ALTER COLUMN id_categoria SET DEFAULT nextval('public.categorias_id_categoria_seq'::regclass);
 F   ALTER TABLE public.categorias ALTER COLUMN id_categoria DROP DEFAULT;
       public               postgres    false    231    230    231            ~           2604    16493    detalle_venta id_detalle    DEFAULT     �   ALTER TABLE ONLY public.detalle_venta ALTER COLUMN id_detalle SET DEFAULT nextval('public.detalle_venta_id_detalle_seq'::regclass);
 G   ALTER TABLE public.detalle_venta ALTER COLUMN id_detalle DROP DEFAULT;
       public               postgres    false    226    227    227                       2604    16520    productos id    DEFAULT     l   ALTER TABLE ONLY public.productos ALTER COLUMN id SET DEFAULT nextval('public.productos_id_seq'::regclass);
 ;   ALTER TABLE public.productos ALTER COLUMN id DROP DEFAULT;
       public               postgres    false    228    229    229            }           2604    16480    ventas id_venta    DEFAULT     r   ALTER TABLE ONLY public.ventas ALTER COLUMN id_venta SET DEFAULT nextval('public.ventas_id_venta_seq'::regclass);
 >   ALTER TABLE public.ventas ALTER COLUMN id_venta DROP DEFAULT;
       public               postgres    false    225    224    225            6          0    16395    Detalle 
   TABLE DATA           Q   COPY public."Detalle" (numero_venta, id_producto, cantidad_vendidad) FROM stdin;
    public               postgres    false    217   SJ       7          0    16398    Producto 
   TABLE DATA           �   COPY public."Producto" (id_producto, nombre_producto, cantidad_stock, costo_unitario, delete, limite_alarmable, id_categoria) FROM stdin;
    public               postgres    false    218   @K       9          0    16404    Usuario 
   TABLE DATA           W   COPY public."Usuario" (dni, nombre, tipo, fecha_nacimiento, clave, delete) FROM stdin;
    public               postgres    false    220   �L       :          0    16409    Ventas 
   TABLE DATA           H   COPY public."Ventas" (numero_venta, fecha, forma_pago, dni) FROM stdin;
    public               postgres    false    221   �M       D          0    16535 
   categorias 
   TABLE DATA           =   COPY public.categorias (id_categoria, categoria) FROM stdin;
    public               postgres    false    231   �N       @          0    16490    detalle_venta 
   TABLE DATA           e   COPY public.detalle_venta (id_detalle, id_venta, id_producto, cantidad, precio_unitario) FROM stdin;
    public               postgres    false    227   O       B          0    16517 	   productos 
   TABLE DATA           �   COPY public.productos (id, id_producto, nombre_producto, cantidad_stock, costo_unitario, limite_alarmante, id_categoria, estado) FROM stdin;
    public               postgres    false    229   3O       <          0    16443    usuarios 
   TABLE DATA           f   COPY public.usuarios (dni_usuario, nombre, tipo_usuario, fecha_nacimiento, clave, estado) FROM stdin;
    public               postgres    false    223   �O       >          0    16477    ventas 
   TABLE DATA           ]   COPY public.ventas (id_venta, dni_usuario, valor_total, fecha_venta, forma_pago) FROM stdin;
    public               postgres    false    225   RQ       O           0    0    Producto_id_producto_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public."Producto_id_producto_seq"', 18, true);
          public               postgres    false    219            P           0    0    Ventas_numero_venta_seq    SEQUENCE SET     H   SELECT pg_catalog.setval('public."Ventas_numero_venta_seq"', 57, true);
          public               postgres    false    222            Q           0    0    categorias_id_categoria_seq    SEQUENCE SET     I   SELECT pg_catalog.setval('public.categorias_id_categoria_seq', 8, true);
          public               postgres    false    230            R           0    0    detalle_venta_id_detalle_seq    SEQUENCE SET     K   SELECT pg_catalog.setval('public.detalle_venta_id_detalle_seq', 1, false);
          public               postgres    false    226            S           0    0    productos_id_seq    SEQUENCE SET     ?   SELECT pg_catalog.setval('public.productos_id_seq', 16, true);
          public               postgres    false    228            T           0    0    ventas_id_venta_seq    SEQUENCE SET     B   SELECT pg_catalog.setval('public.ventas_id_venta_seq', 1, false);
          public               postgres    false    224            �           2606    16418    Producto Producto_pkey 
   CONSTRAINT     a   ALTER TABLE ONLY public."Producto"
    ADD CONSTRAINT "Producto_pkey" PRIMARY KEY (id_producto);
 D   ALTER TABLE ONLY public."Producto" DROP CONSTRAINT "Producto_pkey";
       public                 postgres    false    218            �           2606    16420    Usuario Vendedor_pkey 
   CONSTRAINT     X   ALTER TABLE ONLY public."Usuario"
    ADD CONSTRAINT "Vendedor_pkey" PRIMARY KEY (dni);
 C   ALTER TABLE ONLY public."Usuario" DROP CONSTRAINT "Vendedor_pkey";
       public                 postgres    false    220            �           2606    16422    Ventas Ventas_pkey 
   CONSTRAINT     ^   ALTER TABLE ONLY public."Ventas"
    ADD CONSTRAINT "Ventas_pkey" PRIMARY KEY (numero_venta);
 @   ALTER TABLE ONLY public."Ventas" DROP CONSTRAINT "Ventas_pkey";
       public                 postgres    false    221            �           2606    16542 #   categorias categorias_categoria_key 
   CONSTRAINT     c   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_categoria_key UNIQUE (categoria);
 M   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_categoria_key;
       public                 postgres    false    231            �           2606    16540    categorias categorias_pkey 
   CONSTRAINT     b   ALTER TABLE ONLY public.categorias
    ADD CONSTRAINT categorias_pkey PRIMARY KEY (id_categoria);
 D   ALTER TABLE ONLY public.categorias DROP CONSTRAINT categorias_pkey;
       public                 postgres    false    231            �           2606    16497     detalle_venta detalle_venta_pkey 
   CONSTRAINT     f   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT detalle_venta_pkey PRIMARY KEY (id_detalle);
 J   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT detalle_venta_pkey;
       public                 postgres    false    227            �           2606    16527 #   productos productos_id_producto_key 
   CONSTRAINT     e   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_id_producto_key UNIQUE (id_producto);
 M   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_id_producto_key;
       public                 postgres    false    229            �           2606    16525    productos productos_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT productos_pkey PRIMARY KEY (id);
 B   ALTER TABLE ONLY public.productos DROP CONSTRAINT productos_pkey;
       public                 postgres    false    229            �           2606    16450    usuarios usuarios_pkey 
   CONSTRAINT     ]   ALTER TABLE ONLY public.usuarios
    ADD CONSTRAINT usuarios_pkey PRIMARY KEY (dni_usuario);
 @   ALTER TABLE ONLY public.usuarios DROP CONSTRAINT usuarios_pkey;
       public                 postgres    false    223            �           2606    16483    ventas ventas_pkey 
   CONSTRAINT     V   ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT ventas_pkey PRIMARY KEY (id_venta);
 <   ALTER TABLE ONLY public.ventas DROP CONSTRAINT ventas_pkey;
       public                 postgres    false    225            �           2606    16423    Ventas dni_vendedor    FK CONSTRAINT     u   ALTER TABLE ONLY public."Ventas"
    ADD CONSTRAINT dni_vendedor FOREIGN KEY (dni) REFERENCES public."Usuario"(dni);
 ?   ALTER TABLE ONLY public."Ventas" DROP CONSTRAINT dni_vendedor;
       public               postgres    false    4750    221    220            �           2606    16484    ventas fk_usuario    FK CONSTRAINT     �   ALTER TABLE ONLY public.ventas
    ADD CONSTRAINT fk_usuario FOREIGN KEY (dni_usuario) REFERENCES public.usuarios(dni_usuario);
 ;   ALTER TABLE ONLY public.ventas DROP CONSTRAINT fk_usuario;
       public               postgres    false    225    4754    223            �           2606    16498    detalle_venta fk_venta    FK CONSTRAINT     }   ALTER TABLE ONLY public.detalle_venta
    ADD CONSTRAINT fk_venta FOREIGN KEY (id_venta) REFERENCES public.ventas(id_venta);
 @   ALTER TABLE ONLY public.detalle_venta DROP CONSTRAINT fk_venta;
       public               postgres    false    227    225    4756            �           2606    16543    productos id_categoria    FK CONSTRAINT     �   ALTER TABLE ONLY public.productos
    ADD CONSTRAINT id_categoria FOREIGN KEY (id_categoria) REFERENCES public.categorias(id_categoria);
 @   ALTER TABLE ONLY public.productos DROP CONSTRAINT id_categoria;
       public               postgres    false    231    4766    229            �           2606    16433    Detalle id_producto    FK CONSTRAINT     �   ALTER TABLE ONLY public."Detalle"
    ADD CONSTRAINT id_producto FOREIGN KEY (id_producto) REFERENCES public."Producto"(id_producto);
 ?   ALTER TABLE ONLY public."Detalle" DROP CONSTRAINT id_producto;
       public               postgres    false    4748    218    217            �           2606    16438    Detalle numero_venta    FK CONSTRAINT     �   ALTER TABLE ONLY public."Detalle"
    ADD CONSTRAINT numero_venta FOREIGN KEY (numero_venta) REFERENCES public."Ventas"(numero_venta);
 @   ALTER TABLE ONLY public."Detalle" DROP CONSTRAINT numero_venta;
       public               postgres    false    4752    217    221            6   �   x�=��m�0C��a�芝]��%E��gK���W�2_���r���Jؚs��0�G�)tƈ�@���ˇLHӢ���=��l9��%���z����z�
��8BZ>���q�;>a�̀7�#L0�\jt`�F9�|�`�R`ԗ�_+��
d�U*S���Y�Z���h�jK�%9ڮ�9��k@e�<gcPN��1�^�����8�^=x�����l�?f���JR      7   ]  x�UR�n�0</_�����WR5m�V�Z��\��
.�M�T��w1�+Čgg��Ѵ�7 8��Ӑ\&1/b��+�H��6δځR��qz�lBrx�z3j�q^�P�79��AG�p`�F���3B��fJJ�*?jk��cUo.���%$�F)[i�wz$&���� y
�,��抠�)T ��G���_����=��M�g��bb�kv!c�&t$��k�{�Ĥ��O�ɖ���3쀝wz`���˕*����2n�/O^Iz�R{
c��E�8��%u7���X34�w_����:�lC(`穩���	��7�m��}�]B�I�1?8�K2�� �H���\P1��tE���u      9     x�]��N1E�ٯ���^�e �v�2��X�%ǋ,@(_Ϛl�4�=�1�8F��PR�!�X�#��^i�F�`����ᱦP`{~�1�Y��	��MK+��YO�r
j�%�x��jB=�cCdnbaWC9�j��4RC,��|m�[�� �ۜ������h,k���2����:Fa/+���s���/uk������3[��k�Ym�g:�ߏ�)�_@�y�~~�Qw���]�82�����T�r�h�9�|��u�7��{6      :   �   x���MJ�0@�q����m���Gj�7���m�uz ������I�I�<�����w��L�ڥ��>�m��~����cȺ�&-��������o}�ʮ��~�c8���C�*����to�x�vp7p���m���~�ǵ���kwWpw� Op���ϡ�C��~�����~>���/���S���}������/�_����ߞj��kG      D   Y   x�3��*M�/�2�tN-*K�J,�2���
�p�gdgW�s�r��d��8CRK3s�LsN�����b ӂӱ �(�$��-F��� �g�      @      x������ � �      B   M   x�34�4�t�ONTH��I�44�400�4����̤�T.C3N#N���l�ļ�Ԝb�BCS�JSNd�1z\\\ ���      <   �  x�m�Kr�@@��)X�5�gz>ZR`�|m���@F�H��QΑ�Ev���t/�^�� eȅT��t\����39�84�M	��w���$x�G���eIQ�B[A.��F�q���:�/�P�@�Lj	�(�=J�M�?�]��$���(��-9�p:ȣ��0��2�/uE�.��N����Չ"��X%�Z�Ȅ�Rr�k\K%�1�h�\p�\�.H͔ �B!�Tl���PR&�s�@h��YI(���r+�ٲ�����Q���Ӥ��������Ӭ�<˗cl�������>$���ݓ}��Ʃ�`�=�y��8�˜N#WnR����x�����Y����Z�������h������]4\,mS��wzNK~6�/��ݾ�\>��m�A/�9{��N&�;��G�Q����ޞ:lYn��W*�?��Ɲ      >      x������ � �     