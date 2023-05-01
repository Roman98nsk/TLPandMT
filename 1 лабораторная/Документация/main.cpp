#include <llvm/Analysis/CallGraph.h>
#include <llvm/IR/Instructions.h>
#include <llvm/IR/InstIterator.h>
#include <llvm/IR/LLVMContext.h>
#include <llvm/IR/Module.h>
#include "llvm/IR/BasicBlock.h"
#include <llvm/IRReader/IRReader.h>
#include <llvm/Support/SourceMgr.h>
#include <llvm/Support/raw_ostream.h>
#include <llvm/Support/CommandLine.h>

#include <string>
#include <stdbool.h>
#include <iostream>
#include <utility>
#include <fstream>
#include <unordered_set>

using namespace std;
using namespace llvm;

int main(int argc, char **argv) {

  cl::opt<string> InputFilename("i", cl::desc("Specify input filename"), cl::value_desc("filename"));
  cl::opt<string> OutputFilename("o", cl::desc("Specify output filename"), cl::value_desc("filename"));
  cl::opt<bool> CallGraph ("dot-callgraph", cl::desc("Boolean flag, display call graph"));
  cl::opt<bool> DefUse ("dot-def-use", cl::desc("Boolean flag, display def-use graph."));
  cl::ParseCommandLineOptions(argc, argv);

  SMDiagnostic Err;
  LLVMContext Context;
  std::unique_ptr<Module> Mod(parseIRFile(InputFilename, Err, Context));

  if (!Mod) {
    Err.print(argv[0], errs());
    return 1;
  }

  auto OutputFile = std::ofstream(OutputFilename);

  std::cout << "\n"
	  << "In: "  << InputFilename << "\n"
	  << "Out: "  << OutputFilename << "\n"
	  << "CallGraph: "  << CallGraph << "\n"
		<< "DefUse: " << DefUse << "\n\n";

  if (CallGraph) {
  	std::string dump;
		raw_string_ostream raw(dump);

    std::unordered_set<std::string> set; // ассоциативный контейнер, содержащий набор уникальных объектов типа Key

    for (auto &F : Mod->functions()) { // Ф-ии
      /*for (auto &BB : F){ // Блоки
        for (auto &I : BB) { // Инструкции из Блоков
          //errs() << I << "\n";
        }
        //errs() << "Basic block (name=" << BB.getName() << ") has "
        //     << BB.size() << " instructions.\n";
      }*/

      // Инструкции из ф-ий
      for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
        // Если встретилась инструкция CallInst, 
        // то извлекаем ее первый операнд, которым 
        // будет являться имя вызываемой функции (callee)
        if(isa<CallInst>(*I)){
          auto callee = cast<CallInst>(*I).getCalledFunction()->getName().str();
          //errs() << callee << "\n";
          set.insert(callee);
        }
        //errs() << *I << "\n";
      } 

      auto name = F.getName().str();
      for (auto &key : set) { // Добавляем к графу ребро
        raw << name << " -> " << key << ";\n";
      }
        set.clear();
    }

    if (OutputFile) {
			OutputFile << "digraph A{\n" << raw.str() << "}";
			OutputFile.close();
		} else {
			std::cout << "digraph A{\n" << raw.str() << "}";
		}
  }

  if (DefUse) {
  	std::string dump;
		raw_string_ostream raw(dump);

    std::unordered_set<std::string> set;

    for (auto &F : Mod->functions()) { // Ф-ии
      // Инструкции из ф-ий
      for (inst_iterator I = inst_begin(F), E = inst_end(F); I != E; ++I) {
        // перебираем все значения, которые использует инструкция
        for (auto &U : I->operands()) {
          Value *v = dyn_cast<Instruction>(U.get());

          if (v) {
            raw << "\"" << *v << "\"" << " ->" << "\"" << *I << "\"" << ";\n";
          }
        }
      } 
    }

    if (OutputFile) {
			OutputFile << "digraph B{\n" << raw.str() << "}";
		} else {
			std::cout << "digraph B{\n" << raw.str() << "}";
		}
  }


}
