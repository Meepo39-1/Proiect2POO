#include <iostream>
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
};
class Apartament: public Locuinta{
    int etaj;
    public:
    /*Metoda va fi adaugata in clasa Apartament dupa formula:
     X*suprafataUtila*(1-Y*discount/100.0),
    */
     void CalculChirie(int X,int Y){
        float chirie=X*suprafataUtila*(1-Y*discount/100.0);
    }
     //constructori de initalizare
    Apartament(string numeClient,int suprafataUtila,int etaj): Locuinta(numeClient,suprafataUtila),etaj(etaj){}
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
        getline(in,ap.numeClient);
        in>>ap.suprafataUtila>>ap.etaj;
        return in;
    } 
    //operator de afisare
    friend ostream &operator<<(ostream& out, Apartament& ap){
        cout<<"Nume Client: "<<ap.numeClient<<endl;
        cout<<"Suprafata utila: "<<ap.suprafataUtila<<endl;
        cout<<"Etaj: "<<ap.etaj<<endl;
        return out;
    }
};
class Casa: public Locuinta{
    int suprafataCurte;
    public:
    /*
      Metoda va fi adaugata in clasa Casa dupa formula
       X*(suprafataUtila+0.2*suprafataCurte)*(1-Y*discount/100.0).
    */
    void CalculChirie(int X,int Y){
        float chirie=X*(suprafataUtila+0.2*suprafataCurte)*(1-Y*discount/100.0);
    }
     bool operator ==(const Casa& c){
        if (this->numeClient==c.numeClient && this->suprafataUtila==c.suprafataUtila&& this->suprafataCurte==c.suprafataCurte)
            return true;
        return false;
    }
    //operator de citire
    friend istream &operator>>(istream& in, Casa& c){
        getline(in,c.numeClient);
        in>>c.suprafataUtila>>c.suprafataCurte;
        return in;
    } 
    //operator de afisare
    friend ostream &operator<<(ostream& out, Casa& c){
        cout<<"Nume Client: "<<c.numeClient<<endl;
        cout<<"Suprafata utila: "<<c.suprafataUtila<<endl;
        cout<<"Suprafata curte: "<<c.suprafataCurte<<endl;
        return out;
    }
};


int main(){
    /*Metodele vor fi testate prin parcurgerea unui vector de pointeri la Locuinta *
    ,incarcat cu obiecte de tip Apartament si Casa.
    */
    Locuinta* locuinte;
    

 



    return 0;
}
