#include <iostream>
#include <vector>
using namespace std;


class Locuinta{
    protected:
        int standard;
        string numeClient;
        int suprafataUtila;
        float discount;
/*La clasa Locuinta se va adauga metoda virtuala pura CalculChirie (X,Y) 
cu X =valoare standard chirie/mp(intreg),
 Y=1 daca se ia in considerare discountul si 0
 daca nu se ia in considerare.*/
 public:
    virtual void CalculChirie(int X,int Y) = 0;
    Locuinta(string numeClient, int suprafataUtila){
        this->numeClient=numeClient;
        this->suprafataUtila=suprafataUtila;
        discount=0;
        standard=5;
    }
    friend ostream &operator<<(ostream& out, Locuinta& ap){
        return out;
    }
};
class Apartament: public Locuinta{
    int etaj;
    static int pretSt;
    public:
    /*Metoda va fi adaugata in clasa Apartament dupa formula:
     X*suprafataUtila*(1-Y*discount/100.0),
    */
    static int GetPretStandard(){
        return pretSt;
    };
     void CalculChirie(int X,int Y){
        float chirie=X*suprafataUtila*(1-Y*discount/100.0);
        cout<<chirie;
    }
     //constructori de initalizare
    Apartament(string numeClient="Pitulica",int suprafataUtila=0,int etaj=0): Locuinta(numeClient,suprafataUtila),etaj(etaj){}
    //constructori de copiere
    Apartament(Apartament &ap):Locuinta(ap.numeClient,ap.suprafataUtila),etaj(ap.etaj){} 
    //Destructor
    ~Apartament(){}
    
    bool operator ==(const Apartament& ap){
        if (this->numeClient==ap.numeClient && this->suprafataUtila==ap.suprafataUtila&& this->etaj==ap.etaj)
            return true;
        return false;
    }
    //operator de citire
    friend istream &operator>>(istream& in, Apartament& ap){
        cout<<"nume=";
        cin.get();
        getline(in,ap.numeClient);
        cout<<endl;
        cout<<"suprafataUtila=";
        in>>ap.suprafataUtila;
        cout<<endl;
        cout<<"etaj=";
        in>>ap.etaj;
        cout<<endl;
        
        return in;
        
    } 
    //operator de afisare
    friend ostream &operator<<(ostream& out, Apartament& ap){
        cout<<"Nume Client: "<<ap.numeClient<<endl;
        cout<<"Suprafata utila: "<<ap.suprafataUtila<<endl;
        cout<<"Etaj: "<<ap.etaj<<endl;
        return out;
    }
    void Afisare(){
        cout<<"Nume Client: "<<numeClient<<endl;
        cout<<"Suprafata utila: "<<suprafataUtila<<endl;
        cout<<"Etaj: "<<etaj<<endl;
    }
};
int Apartament::pretSt=0;
class Casa: public Locuinta{
  
    int suprafataCurte;
    static int pretSt;

    public:
    /*
      Metoda va fi adaugata in clasa Casa dupa formula
       X*(suprafataUtila+0.2*suprafataCurte)*(1-Y*discount/100.0).
    */
    static int GetPretStandard (){
        return pretSt;
    }
    void CalculChirie(int X,int Y){
        float chirie=X*(suprafataUtila+0.2*suprafataCurte)*(1-Y*discount/100.0);
        cout<<"chirie= "<<chirie;
    }
     //constructori de initalizare
    Casa(string numeClient="Pitulica",int suprafataUtila=0,int suprafataCurte=0): Locuinta(numeClient,suprafataUtila),suprafataCurte(suprafataCurte){}
    //constructori de copiere
    Casa(Casa &c):Locuinta(c.numeClient,c.suprafataUtila),suprafataCurte(c.suprafataCurte){} 
    //Destructor
    ~Casa(){}

  
    bool operator ==(const Casa& c){
        if (this->numeClient==c.numeClient && this->suprafataUtila==c.suprafataUtila&& this->suprafataCurte==c.suprafataCurte)
            return true;
        return false;
    }
    //operator de citire
    friend istream &operator>>(istream& in, Casa& c){
        cin.get();
        cout<<"numeClient=";
        getline(in,c.numeClient);
        cout<<endl;
        cout<<"suprafataUtila=";
        in>>c.suprafataUtila;
        cout<<endl;
        cout<<"suprafataCurte=";
        in>>c.suprafataCurte;
        cout<<endl;
        return in;
    } 
    //operator de afisare
    friend ostream& operator<<(ostream& out, Casa& c){
        cout<<"Nume Client: "<<c.numeClient<<endl;
        cout<<"Suprafata utila: "<<c.suprafataUtila<<endl;
        cout<<"Suprafata curte: "<<c.suprafataCurte<<endl;
        return out;
    }
    void Afisare(){
        cout<<"Nume Client: "<<numeClient<<endl;
        cout<<"Suprafata utila: "<<suprafataUtila<<endl;
        cout<<"Suprafata curte: "<<suprafataCurte<<endl;
    }

    string GetNumeClient() const{
        return this->numeClient;
    }
    
};
int Casa:: pretSt=0;
class AgentieImobiliara{
    vector <Locuinta*> locuinte;
    static int nr_locuinte;
   
public:
    //constructori initializare
    AgentieImobiliara(){
        this->nr_locuinte=0;
    };

    AgentieImobiliara(int numar, vector<Locuinta*> loc){
        this->nr_locuinte=numar;
        this->locuinte=loc;
    };
    static void update_locuinte(int addition){
         nr_locuinte=addition+nr_locuinte;
    }
    static int numarLocuinte(){
        return nr_locuinte;
    }
    void addLocuinta(Locuinta *locuinta_noua){
       locuinte.push_back(locuinta_noua);
       update_locuinte(1);
    }
    friend istream& operator>>(istream& in, AgentieImobiliara& agentie){
        cout<<"Introdu numar locuinte:";
        int nr;
        cin>>nr;
        for(int i=0; i<nr; i++){
            int alegere;
            cout<<"1-casa,2-apartament:";
            cin>>alegere;
            if(alegere==1){
                Casa* c= new Casa();
                cin>>(*c); 
                agentie.addLocuinta(c);
            }
            else if(alegere==2){
                Apartament* p= new Apartament;
                cin>>(*p);
                agentie.addLocuinta(p);
            }
            
        }
        return in;
    }   
    friend ostream& operator<<(ostream& out, AgentieImobiliara& agentie){
        cout<<"numar locuinte:";
        int nr=numarLocuinte();
        cout<<nr<<endl;
        for (int i=0; i<nr; i++){
            if (Casa* c=dynamic_cast<Casa*>(agentie.locuinte[i]))
                cout<<(*c);
            else if (Apartament* ap=dynamic_cast<Apartament*>(agentie.locuinte[i]))
                cout<<(*ap);
        }
        
        return out;
    }          

};
int AgentieImobiliara::nr_locuinte=0;

int main(){
    /*Metodele vor fi testate prin parcurgerea unui vector de pointeri la Locuinta *
    ,incarcat cu obiecte de tip Apartament si Casa.
    */
    AgentieImobiliara agentie;
    cout<<"Bine ati venit la preavestita noastra agentie imobiliara!"<<endl;
    cout<<"Cate locuinte doriti sa inchiriati? Introduceti numarul:";
    int n,discount=0,chirie;
    cin>>n;
    char alegere,spatiu;
    for(int i=1; i<=n; i++){
        cout<<"Ce fel de locuinta doriti sa inchiriati? Aceasta este locuinta cu numarul"<<i<<"Introduceti litera C/A:"<<endl;  
        cin>>alegere;
        cout<<"alegere="<<alegere;
        if (alegere=='C'){
            Casa* c= new Casa();
            cin>>(*c);
            c->Afisare();
            
            cout<<"Doriti sa luati in considerare discount-ul? Introduceti raspunsul Y/N:"<<endl;
            cin>>alegere;
            cout<<"alegere="<<alegere;
            
            if(alegere=='Y')
                discount=1;
                
            cout<<"Doriti sa calculati chiria cu pretul automat sau manual?Introduceti raspunsul M/A:"<<endl;
            cin>>alegere;
            cout<<"alegere="<<alegere;
            
            if(alegere=='A')
                c->CalculChirie(c->GetPretStandard(),discount);
            else if(alegere=='M'){
                cout<<"Introduceti suma chiriei:";
                cin>>chirie;
                c->CalculChirie(chirie,discount);
            }
            agentie.addLocuinta(c);
            
        }
        else if(alegere=='A'){
        Apartament* ap= new Apartament();
        cin>>(*ap);
        ap->Afisare();
        ap->CalculChirie(2,3);

        cout<<"Doriti sa luati in considerare discount-ul? Introduceti raspunsul Y/N:"<<endl;
            cin>>alegere;
            cout<<"alegere="<<alegere;
            
            if(alegere=='Y')
                discount=1;
                
            cout<<"Doriti sa calculati chiria cu pretul automat sau manual?Introduceti raspunsul M/A:"<<endl;
            cin>>alegere;
            cout<<"alegere="<<alegere;
            
            if(alegere=='A')
                ap->CalculChirie(ap->GetPretStandard(),discount);
            else if(alegere=='M'){
                cout<<"Introduceti suma chiriei:";
                cin>>chirie;
                ap->CalculChirie(chirie,discount);
            }
        agentie.addLocuinta(ap);
        }
    }
    
    cout<<agentie; 
   
   /* cout<<agentie;
    Casa* c= new Casa();
    agentie.addLocuinta(c);
    cout<<agentie;
    */
    return 0;
}

