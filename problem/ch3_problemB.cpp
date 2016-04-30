#include <iostream>
#include <sstream>
#include <vector>
#include <map>

using namespace std;

typedef struct strPerson {
	string Name;
	string Career;
	string Favorite;
	string Hometown;
} Person;

void split(string& s, const string& delim, vector< string >* ts);

class Scanner{
	vector< Person > person;
	bool hasDescripted = false;
	int countSort[4];

public:
	bool Prog(vector< string > &s) {
		if (hasDescripted)	{ Dcl(s); return true;  }
		else if (!Description(s)) {
			cout << "valid input" << endl;
			return false;
		}
	};

	bool Description(vector< string > &s) {
		int i = 0;
		int flag = 0;
		while (i < s.size()) {
			if (s[i] == "Name") { countSort[0] = i; flag++; }
			if (s[i] == "Career") { countSort[1] = i; flag++; }
			if (s[i] == "Favorite") { countSort[2] = i; flag++; }
			if (s[i] == "Hometown") { countSort[3] = i; flag++; }
			i++;
		}
		if (4 != flag) return false;
		hasDescripted = true;
		return true;
	}

	void Dcl(vector< string > &s) {
		Person temp;
		for (int i = 0; i < s.size(); i++)
		{
			if (countSort[0] == i) { temp.Name = s[i]; }
			if (countSort[1] == i) { temp.Career = s[i]; }
			if (countSort[2] == i) { temp.Favorite = s[i]; }
			if (countSort[3] == i) { temp.Hometown = s[i]; }
		}
		person.push_back(temp);
	}

	void match(const string s) {
		for (int i = 0; i < person.size(); i++)
		{
			if (s == person[i].Favorite) { printElement(person[i]); }
		}
	}

	void printElement(Person person) {
		for (int i = 0; i < 4; i++)
		{
			if (countSort[0] == i) { cout << person.Name << "\t"; }
			if (countSort[1] == i) { cout << person.Career << "\t"; }
			if (countSort[2] == i) { cout << person.Favorite << "\t"; }
			if (countSort[3] == i) { cout << person.Hometown << "\t"; }
		}
		cout << endl;
	}
};

//typedef struct variable_token {
//	std::string id;
//	std::string Astring;
//} vtoken;

//class Person {
//private:
//	typedef pair < int, vtoken > __feature__;
//	map < int, vtoken > tokenFeature;
//
//public:
//
//	void constructor(int i, string id) {
//		vtoken v;
//		v.id = id;
//		tokenFeature.insert(__feature__(i, v));
//	}
//
//	void setValue(int i, string id) {
//		tokenFeature.at(i).Astring = id;
//	}
//
//	void printElement() {
//		for (int i = 0; i < 4; i++)
//		{
//			cout << this->tokenFeature.at(i).Astring << "\t";
//		}
//		cout << endl;
//	}
//};

int main() {
	int i,strL;
	string str, s;
	vector < string > ts;
	ostringstream tmpStr;

	Scanner scanner;
	while (getline(cin, str))
	{
		i = 0;
		strL = str.length();
		while (i < strL) {
			if (((str[i] >= 'A' && str[i] <= 'Z') || ('a' <= str[i] && 'z' >= str[i])) && i + 1 < strL) {
				tmpStr << str[i];
				++i;
				while ((str[i] >= 'A' && str[i] <= 'Z') || ('a' <= str[i] && 'z' >= str[i]))
				{
					tmpStr << str[i];
					++i;
				}
				tmpStr << " ";
			}
			else {
				switch (str[i]) {
					case ' ':
					case '\t':
						i++;
						break;
					default:
						cout << "valid input";
						return -1;
				}
			}
		}
		s = tmpStr.str();
		cout << "hello world";
		tmpStr.str("");
		split(s, " ", &ts);
		if (!scanner.Prog(ts)) return -1;
		ts.clear();
		s.clear();
	}
	scanner.match("noodles");
	return 0;
}

void split(string& s, const string& delim, vector< string >* ts) {
	int prev = 0;
	int i = s.find_first_of(delim, prev);
	while (i != string::npos)
	{
		ts->push_back(s.substr(prev, i - prev));
		prev = i + 1;
		i = s.find(delim, prev);
	}
	if (i - prev > 0)
	{
		ts->push_back(s.substr(prev, i - prev));
	}
}
