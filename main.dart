import 'package:flutter/material.dart';
import 'model/produto_model.dart';
import 'widgets/chip_info.dart';
import 'widgets/text_field_widget.dart';

void main() {
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Cadastro de Produto',
      theme: ThemeData(
        colorScheme: ColorScheme.fromSeed(seedColor: Color.fromARGB(255, 223, 226, 7)),
        useMaterial3: true,
      ),
      home: const ProductListPage(),
      debugShowCheckedModeBanner: false,
    );
  }
}

class ProductListPage extends StatefulWidget {
  const ProductListPage({super.key});

  @override
  State<ProductListPage> createState() => _ProductListPageState();
}

class _ProductListPageState extends State<ProductListPage> {
  final List<ProdutoModel> productData = [
    ProdutoModel(
      nome: 'Smartphone Galaxy',
      precoCompra: 1199.99,
      precoVenda: 1599.99,
      quantidade: 17,
      descricao: 'Celular com câmera tripla e ótima performance.',
      categoria: 'Eletrônicos',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcRjteVXpwXK5aWtJlTJaICkJ0y6fOfv_5la5w&s',
      ativo: true,
      emPromocao: true,
      desconto: 12.0,
    ),
    ProdutoModel(
      nome: 'Camiseta Polo Masculina',
      precoCompra: 35.90,
      precoVenda: 59.90,
      quantidade: 50,
      descricao: 'Camiseta polo 100% algodão.',
      categoria: 'Roupas',
      imagem: 'https://encrypted-tbn0.gstatic.com/images?q=tbn:ANd9GcSx13LGizQwG0n0y3yL5lloi7lAhpgojSYmog&s',
      ativo: false,
      emPromocao: false,
      desconto: 0,
    ),
    ProdutoModel(
      nome: 'Tênis Air Jordan 1 Low Masculino',
      precoCompra: 1020.00,
      precoVenda: 1044.99,
      quantidade: 72,
      descricao: 'Tênis leve e confortável para todas as ocasiões.',
      categoria: 'Calçados',
      imagem: 'https://images.tcdn.com.br/img/img_prod/740066/air_jordan_1_high_og_wmns_satin_red_1763_1_20200806172945.jpg',
      ativo: true,
      emPromocao: true,
      desconto: 15,
    ),
    ProdutoModel(
      nome: 'Notebook Dell Inspiron',
      precoCompra: 2999.99,
      precoVenda: 3799.99,
      quantidade: 34,
      descricao: 'Notebook com 16GB RAM, SSD 512GB e Intel i7.',
      categoria: 'Eletrônicos',
      imagem: 'https://imgs.casasbahia.com.br/55066981/1g.jpg?',
      ativo: true,
      emPromocao: false,
      desconto: 10,
    ),
  ];

  void addProduct(ProdutoModel product) {
    setState(() {
      productData.add(product);
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text(
          'Lista de Produtos',
          style: TextStyle(color: Colors.white),
        ),
        centerTitle: true,
        backgroundColor: Color.fromARGB(255, 223, 226, 7),
      ),
      backgroundColor: Colors.grey[100],
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () async {
          final result = await Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => ProductFormPage(),
            ),
          );
          if (result != null && result is ProdutoModel) {
            addProduct(result);
          }
        },
        label: const Text(
          'Novo Produto',
          style: TextStyle(color: Colors.black),
        ),
        icon: const Icon(Icons.add, color: Colors.black),
        backgroundColor: const Color.fromARGB(255, 223, 226, 7),
      ),
      body: productData.isEmpty
          ? const Center(child: Text('Nenhum produto cadastrado.'))
          : ListView.builder(
              itemCount: productData.length,
              itemBuilder: (context, index) {
                final product = productData[index];
                return ListTile(
                  contentPadding: const EdgeInsets.symmetric(vertical: 12, horizontal: 16),
                  leading: Image.network(
                    product.imagem ?? '',
                    width: 100,
                    height: 200,
                    fit: BoxFit.cover,
                    errorBuilder: (context, error, stackTrace) =>
                        const Icon(Icons.broken_image, size: 200),
                  ),
                  title: Text(
                    product.nome,
                    style: const TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                  subtitle: Text(
                    'R\$ ${product.precoVenda.toStringAsFixed(2)}',
                    style: const TextStyle(fontSize: 16),
                  ),
                  trailing: const Icon(Icons.arrow_forward_ios, size: 18),
                  onTap: () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => ProductDetailPage(product: product),
                      ),
                    );
                  },
                );
              },
            ),
    );
  }
}

class ProductFormPage extends StatefulWidget {
  const ProductFormPage({super.key});

  @override
  State<ProductFormPage> createState() => _ProductFormPageState();
}

class _ProductFormPageState extends State<ProductFormPage> {
  final _formKey = GlobalKey<FormState>();
  final _nomeController = TextEditingController();
  final _precoCompraController = TextEditingController();
  final _precoVendaController = TextEditingController();
  final _quantidadeController = TextEditingController();
  final _descricaoController = TextEditingController();
  final _imagemController = TextEditingController();
  String categoria = 'Eletrônicos';
  bool ativo = true;
  bool emPromocao = false;
  double desconto = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Cadastro de Produto'),
        backgroundColor: Color.fromARGB(255, 223, 226, 7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            children: [
              TextFieldWidget(
                labelText: 'Nome',
                hintText: 'Digite o nome do produto',
                icon: const Icon(Icons.text_fields),
                controller: _nomeController,
                validator: (value) => value!.isEmpty ? 'Informe o nome' : null,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                labelText: 'Preço de Compra',
                hintText: 'Digite o preço de compra',
                icon: const Icon(Icons.attach_money),
                controller: _precoCompraController,
                keyboard: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe o preço de compra' : null,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                labelText: 'Preço de Venda',
                hintText: 'Digite o preço de venda',
                icon: const Icon(Icons.money),
                controller: _precoVendaController,
                keyboard: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe o preço de venda' : null,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                labelText: 'Quantidade',
                hintText: 'Digite a quantidade',
                icon: const Icon(Icons.numbers),
                controller: _quantidadeController,
                keyboard: TextInputType.number,
                validator: (value) => value!.isEmpty ? 'Informe a quantidade' : null,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                labelText: 'Descrição',
                hintText: 'Digite a descrição do produto',
                icon: const Icon(Icons.description),
                controller: _descricaoController,
                validator: (value) => value!.isEmpty ? 'Informe a descrição' : null,
              ),
              const SizedBox(height: 10),
              TextFieldWidget(
                labelText: 'URL da Imagem',
                hintText: 'Cole a URL da imagem do produto',
                icon: const Icon(Icons.image),
                controller: _imagemController,
              ),
              const SizedBox(height: 10),
              const Align(
                alignment: Alignment.centerLeft,
                child: Text('Categoria', style: TextStyle(fontWeight: FontWeight.bold)),
              ),
              Column(
                children: ['Eletrônicos', 'Roupas', 'Calçados', 'Informática']
                    .map(
                      (e) => RadioListTile(
                        title: Text(e),
                        value: e,
                        groupValue: categoria,
                        onChanged: (value) {
                          setState(() {
                            categoria = value!;
                          });
                        },
                      ),
                    )
                    .toList(),
              ),
              SwitchListTile(
                title: const Text('Produto Ativo'),
                value: ativo,
                onChanged: (value) {
                  setState(() {
                    ativo = value;
                  });
                },
              ),
              CheckboxListTile(
                title: const Text('Em Promoção'),
                value: emPromocao,
                onChanged: (value) {
                  setState(() {
                    emPromocao = value!;
                  });
                },
              ),
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text('Desconto (%)'),
                  Slider(
                    value: desconto,
                    min: 0,
                    max: 100,
                    divisions: 20,
                    label: '${desconto.round()}%',
                    onChanged: (value) {
                      setState(() {
                        desconto = value;
                      });
                    },
                  ),
                ],
              ),
              const SizedBox(height: 20),
              ElevatedButton(
                style: ElevatedButton.styleFrom(
                  backgroundColor: const Color.fromARGB(255, 223, 226, 7),
                ),
                onPressed: () {
                  if (_formKey.currentState!.validate()) {
                    final product = ProdutoModel(
                      nome: _nomeController.text,
                      precoCompra: double.parse(_precoCompraController.text),
                      precoVenda: double.parse(_precoVendaController.text),
                      quantidade: int.parse(_quantidadeController.text),
                      descricao: _descricaoController.text,
                      categoria: categoria,
                      imagem: _imagemController.text,
                      ativo: ativo,
                      emPromocao: emPromocao,
                      desconto: desconto,
                    );
                    Navigator.pop(context, product);
                  }
                },
                child: const Text(
                  'Cadastrar Produto',
                  style: TextStyle(color: Colors.black),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

class ProductDetailPage extends StatelessWidget {
  final ProdutoModel product;
  const ProductDetailPage({super.key, required this.product});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(product.nome),
        backgroundColor: Color.fromARGB(255, 223, 226, 7),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              product.imagem ?? '',
              width: double.infinity,
              height: 200,
              fit: BoxFit.cover,
              errorBuilder: (context, error, stackTrace) =>
                  const Center(child: Icon(Icons.broken_image, size: 100)),
            ),
            const SizedBox(height: 16),
            Text(product.nome, style: const TextStyle(fontSize: 22, fontWeight: FontWeight.bold)),
            const SizedBox(height: 8),
            Text('Categoria: ${product.categoria}'),
            const SizedBox(height: 8),
            Text('Descrição: ${product.descricao}'),
            const SizedBox(height: 8),
            Text('Preço de Compra: R\$ ${product.precoCompra.toStringAsFixed(2)}'),
            Text('Preço de Venda: R\$ ${product.precoVenda.toStringAsFixed(2)}'),
            const SizedBox(height: 8),
            Text('Quantidade: ${product.quantidade} unidades'),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(product.ativo ? Icons.check_circle : Icons.cancel,
                    color: product.ativo ? Colors.green : Colors.red),
                const SizedBox(width: 8),
                Text(product.ativo ? 'Produto Ativo' : 'Produto Inativo'),
              ],
            ),
            const SizedBox(height: 8),
            Row(
              children: [
                Icon(product.emPromocao ? Icons.local_offer : Icons.local_offer_outlined,
                    color: product.emPromocao ? Colors.orange : Colors.grey),
                const SizedBox(width: 8),
                Text(product.emPromocao
                    ? 'Produto em promoção (${product.desconto.round()}% de desconto)'
                    : 'Sem promoção'),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
