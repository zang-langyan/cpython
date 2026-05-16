# PYTHONPATH=$(srcdir)/Tools/peg_generator $(PYTHON_FOR_REGEN)
import sys
sys.path.append('../Tools/peg_generator')
import tokenize
from tabulate import tabulate
import tempfile

from pegen.c_generator import CParserGenerator
from pegen.grammar import Grammar, GrammarVisitor
from pegen.grammar_parser import GeneratedParser as GrammarParser
from pegen.parser import Parser
from pegen.parser_generator import ParserGenerator
from pegen.python_generator import PythonParserGenerator
from pegen.tokenizer import Tokenizer
from pegen.build import build_c_generator, generate_token_definitions
grammar_file = '../Grammar/python.gram'
tokens_file = '../Grammar/Tokens'

# options
option_wpgt = False

def write_python_grammar_tokens(tokens):
    table_data = []
    cur = -1
    for tok in tokens:
        if tok.type in [65, 66, ]:
            continue
        if cur != -1 and cur != tok.start[0]:
            table_data.append(['-'] * 6)
        cur = tok.start[0]
        type_name = tokenize.tok_name[tok.type]
        table_data.append([
            f'{tok.type}: {type_name}',
            f'{tok.exact_type}: {tokenize.tok_name[tok.exact_type]}',
            f'{repr(tok.string):.72}',
            f'{tok.start[0]},{tok.start[1]}',
            f'{tok.end[0]},{tok.end[1]}',
            repr(tok.line.rstrip('\n')),
        ])
    with open('./python.grammar.tokens', 'w') as tf:
        headers = [
            'Type (typeid: typename)', 
            'Exact Type (typeid: typename)', 
            'String', 
            'Start (row,col)', 
            'End (row,col)', 
            'Line', 
        ]
        tf.write(tabulate(table_data, headers=headers, tablefmt='psql'))



with open(grammar_file) as f:
    tokens = tokenize.generate_tokens(f.readline)
    if option_wpgt:
        write_python_grammar_tokens(tokens)
        tokens = tokenize.generate_tokens(f.readline)


    tokenizer = Tokenizer(tokens, verbose = False)
    parser = GrammarParser(tokenizer, verbose = False)
    grammar = parser.start()

    # print('\nGrammar:')
    # print(grammar)

    visitor = GrammarVisitor()
    print('Grammar Visitor:')
    for name, rule in grammar.rules.items():
        visitor.visit(rule)

    # with open(tokens_file) as tok_file:
    #     all_tokens, exact_tok, non_exact_tok = generate_token_definitions(tok_file)
    # with tempfile.TemporaryFile(mode='w+t') as file:
    #     gen: ParserGenerator = CParserGenerator(
    #         grammar, all_tokens, exact_tok, non_exact_tok, file, skip_axtions=False
    #     )
    #     gen.collect_rules()