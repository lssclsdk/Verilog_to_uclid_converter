#include "Map.h"
#include <bits/stdc++.h>
using namespace std;
#include "Message.h"
#include "veri_file.h"
#include "VeriWrite.h"
#include "DataBase.h"
#include "Strings.h"
#ifdef USE_COMREAD
#include "Commands.h"
#include "ComRead.h"
#endif

#ifdef VERIFIC_NAMESPACE
using namespace Verific ;
#endif


string modif(string name){
  int pos =  0;
  for(int i=0;i < (int)name.length();i++){
    char c = name[i];
    if(c=='['){
      pos = i;
      break;
    }
  }
  if(pos != 0){
    name = name.substr(0,pos) + '_' + name.substr(pos+1,name.length() - pos -2);
    return name;
  }
  else
  return name;
}


string Printports(Netlist *top) {
  MapIter mi1;
  char *name1;
  Port *por1;
  string spor = "";
  string sinp = "";
  string sou = "";
  Map *pors1 = top->GetPorts();
  FOREACH_MAP_ITEM(pors1,mi1,&name1,&por1){
    if(por1->IsInput()){
      sinp = sinp + modif(name1) + " , " ;
      }
    else if(por1->IsOutput()){
      sou = sou + modif(name1) + " , " ;
      }
    }
  if((int)sinp.length() != 0)
    spor = (string)"input " + sinp.substr(0,sinp.length() - 2) + " : " + "bv1" + " ;\n";
  if((int)sou.length() != 0)
    spor = spor + "output " + sou.substr(0,sou.length() - 2) + " : " + "bv1" + " ;\n";
  return spor;
}





string PrintNets(Netlist *top){
  Map *ns = top->GetNets();
  MapIter mi;
  char *name;
  Net *ne;
  string snet = "";
  string sn = "";

  FOREACH_MAP_ITEM(ns,mi,&name,&ne){
    if(!(top->GetPort(name))){
      sn = sn + modif(name) + " , ";
    }
  }
  if((int)sn.length() != 0)
  snet = (string)"var " + sn.substr(0,sn.length() - 2) + " : " + "bv1" + " ;\n";
  return snet;
}

string Printinst(Netlist *top){
  const Map *ins = top->GetInsts();
  MapIter mi;
  char *name;
  Instance *in;
  string sins = "";
  string nbloc = "";
  FOREACH_MAP_ITEM(ins,mi,&name,&in){
    if(strcmp(in->View()->Owner()->Name(),"VERIFIC_GND") == 0 || strcmp(in->View()->Owner()->Name(),"VERIFIC_X") == 0){
        Net *ne = in->GetOutput();
        nbloc += modif(ne->Name()) + (string)"\'" + " = 0bv1 ;\n";
        continue;
    }
    else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_PWR") == 0){
        Net *ne = in->GetOutput();
        nbloc += modif(ne->Name()) + (string)"\'" + " = 1bv1 ;\n";
        continue;
     }
     else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_AND") == 0){
         Net *ne1 = in->GetInput1();
         Net *ne2 = in->GetInput2();
         Net *ne3 = in->GetOutput();
         nbloc += modif(ne3->Name()) + (string)"\'" + " = " + modif(ne1->Name()) + "\' & " + modif(ne2->Name()) + "\' ;\n";
         continue;
      }
      else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_OR") == 0){
          Net *ne1 = in->GetInput1();
          Net *ne2 = in->GetInput2();
          Net *ne3 = in->GetOutput();
          nbloc += modif(ne3->Name()) + (string)"\'" + " = " + modif(ne1->Name()) + "\' | " + modif(ne2->Name()) + "\' ;\n";
          continue;
       }
       else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_XOR") == 0){
           Net *ne1 = in->GetInput1();
           Net *ne2 = in->GetInput2();
           Net *ne3 = in->GetOutput();
           nbloc += modif(ne3->Name()) + (string)"\'" + " = " + modif(ne1->Name()) + "\' ^ " + modif(ne2->Name()) + "\' ;\n"; //+ " || ((! "  + modif(ne1->Name()) + "\') && " + modif(ne2->Name()) + "\')" + ";\n";
           continue;
        }
        else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_INV") == 0){
            Net *ne1 = in->GetInput();
            Net *ne3 = in->GetOutput();
            nbloc += modif(ne3->Name()) + (string)"\'" + " = ~ " + modif(ne1->Name()) + "\' ;\n";
            continue;
         }
         else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_MUX") == 0){
           Net *ne1 = in->GetInput1();
           Net *ne2 = in->GetInput2();
           Net *ne3 = in->GetOutput();
           Net *c = in->GetControl();
           nbloc += "if (" + modif(c->Name()) +"\' == 1bv1 ) {\n" + modif(ne3->Name()) + "\' = " + modif(ne1->Name()) + "\'; \n} else {\n" +  modif(ne3->Name()) + "\' = " + modif(ne2->Name()) + "\' ; \n}\n";
             continue;
          }
          else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_MUX") == 0){
            Net *ne1 = in->GetInput1();
            Net *ne2 = in->GetInput2();
            Net *ne3 = in->GetOutput();
            Net *c = in->GetControl();
            nbloc += "if (" + modif(c->Name()) +"\' == 1bv1 ) {\n" + modif(ne3->Name()) + "\' = " + modif(ne1->Name()) + "\'; \n} else {\n" +  modif(ne3->Name()) + "\' = " + modif(ne2->Name()) + "\' ; \n}\n";
              continue;
           }
           else if(strcmp(in->View()->Owner()->Name(),"VERIFIC_FADD") == 0){
             Net *ne1 = in->GetInput1();
             Net *ne2 = in->GetInput2();
             Net *ne3 = in->GetOutput();
             Net *ci = in->GetCin();
             Net *co = in->GetCout();
             nbloc += modif(ne3->Name()) + "\' = " +  modif(ci->Name()) +"\' ^ " + modif(ne1->Name()) +"\' ^ " + modif(ne2->Name()) + "\' ;\n" ;
             nbloc+=  modif(co->Name()) + "\' = " + modif(ne1->Name()) + "\' & " + modif(ne2->Name())  + "\' | " +  modif(ne2->Name())  + "\' & " + modif(ci->Name())  + "\' | " + modif(ne1->Name()) + "\' & " + modif(ci->Name()) + "\' ;\n" ;
               continue;
            }

     MapIter mi1 ;
     PortRef *pr ;
    sins = sins + "instance " + name + " : " + in->View()->Owner()->Name() + "( ";
    FOREACH_PORTREF_OF_INST(in, mi1, pr) {
      Net *ne = pr->GetNet();
      Port *por = pr->GetPort();
      sins = sins + modif(por->Name()) + " : (" + modif(ne->Name()) + ") , ";
     }
     sins = sins.substr(0,sins.length() - 2)+ "); \n";

  }
  if(nbloc.length() != 0)
  sins = "next {\n" + nbloc + "}\n"  + sins;
  return sins;
}



int main(int argc, char **argv)
{
    if (argc < 2) Message::PrintLine("Default input file: top.v. Specify command line argument to override") ;

    const char *file_name = 0 ;
    if (argc>1) {
        file_name = argv[1] ;
    } else {
        file_name = "alu.v" ;
    }

#ifdef USE_COMREAD
    const char* def_args[] =  {"read", file_name, "-verilog_2000"} ;
    const char def_argc = 3 ;
    Command *mainline = new ComRead() ;
    if(!mainline->ParseArgs(def_argc, def_args)) {
        mainline->Usage() ;
        delete mainline ;
        return 1 ;
    }
    if(!mainline->Process(0)) {
        mainline->Usage() ;
        delete mainline ;
        return 2 ;
    }
#else
    if (!veri_file::Read(file_name,"work", veri_file::VERILOG_2K )) return 1 ;
#endif
    Netlist *top = Netlist::PresentDesign() ;
    if (!top) {
        Message::PrintLine("Cannot find any handle to the top-level netlist") ;
        return 3 ;
    }
    Message::Msg(VERIFIC_INFO, 0, top->Linefile(), "top level design is %s(%s)",
                 top->Owner()->Name(), top->Name()) ;

    char *before_write = Strings::save(top->Owner()->Name(), "_before_write.v") ;
    string mod = (string)"module main"  + (string)" {\n" + Printports(top) + PrintNets(top) + Printinst(top) +"}\n";

    string smod = "", spri = "";
    Set netlists(POINTER_HASH) ;
    top->Hierarchy(netlists, 1 ) ;
    SetIter si ;
    Netlist *netlist ;
    FOREACH_SET_ITEM(&netlists, si, &netlist) {
      if (netlist->IsOperator()){
        smod =  smod + "module " + netlist->Owner()->Name() + " {\n" + Printports(netlist) + PrintNets(netlist) + Printinst(netlist) + "}\n\n\n" ;
      }
      
  }
  string fstr = spri + "\n" + smod  + "\n" + mod;
    ofstream out((string)top->Owner()->Name() + ".ucl");
    out << fstr;
    out.close();
    VeriWrite veriWriter;
    veriWriter.WriteFile(before_write, top) ;
    Strings::free(before_write) ;
    return 0 ;
}
