#include <iostream>
#include <sstream>

using namespace std;

class Parser {
public:
	Parser(string in) : tStr(in) {}

	bool matching() {
		iStr.str(tStr);
		return Proc();
	}

private:
	string tStr, tmpStr;
	istringstream iStr;

	bool match(string in) { return (iStr >> tmpStr) && (tmpStr == in); }

	bool Proc() { return Dcl() && Stmt(); }

	bool Dcl() { return match("teamnumber") && ID(); }

	bool ID() {
		iStr >> tmpStr;
		if (tmpStr == "cid") {
			return match("name");
		}
		else if (tmpStr == "name") {
			return match("cid");
		}
		else {
			return false;
		}
	}

	bool Stmt() {
		iStr >> tmpStr;
		if (tmpStr == "cooperate") {
			return ID();
		}
		else if (tmpStr == "$") {
			return true;
		}
		else {
			return false;
		}
	}
};

bool strMatch(char in) {
	return in >= 'a' && in <= 'z';
}

bool nMatch(char cha) {
	return cha >= '0' && cha <= '9';
}

int main() {
	string str;
	int i, strL;
	ostringstream tmpStr, tStr, rStr;

	while (getline(cin, str)) {
		i = 0;
		strL = str.length();

		while (i < strL) {
			if (str[i] >= 'A' && str[i] <= 'Z') {
				if (i + 1 < strL && strMatch(str[i + 1])) {
					tmpStr << str[i];
					++i;
					while (i < strL && strMatch(str[i])) {
						tmpStr << str[i];
						++i;
					}
					rStr << "name " << tmpStr.str() << endl;
					tmpStr.str("");
					tStr << "name ";
				}
				else if (i + 1 < strL && str[i + 1] == ' ') {
					rStr << "name " << str[i] << endl;
					tStr << "name ";
					++i;
				}
				else {
					rStr << "wrong" << endl;
					tStr << "wrong ";
					++i;
				}
			}
			else {
				switch (str[i]) {
				case 't':
					if (i + 1 < strL && nMatch(str[i + 1])) {
						tmpStr << str[i];
						++i;
						while (i < strL && nMatch(str[i])) {
							tmpStr << str[i];
							++i;
						}
						rStr << "teamnumber " << tmpStr.str() << endl;
						tmpStr.str("");
						tStr << "teamnumber ";
						++i;
						break;
					}
					else {
						rStr << "wrong" << endl;
						tStr << "wrong ";
						++i;
						break;
					}
				case 'c':
					rStr << "cooperate c" << endl;
					tStr << "cooperate ";
					++i;
					break;
				case '0':
				case '1':
				case '2':
				case '3':
				case '4': 
				case '5':
				case '6':
				case '7':
				case '8':
				case '9':
					tmpStr << str[i];
					++i;
					while (i < strL && nMatch(str[i])) {
						tmpStr << str[i];
						++i;
					}
					rStr << "cid " << tmpStr.str() << endl;
					tmpStr.str("");
					tStr << "cid ";
					break;
				case ' ':
					++i;
					break;
				default:
					rStr << "wrong " << endl;
					tStr << "wrong ";
					++i;
					break;
				}
			}
		}
	}
	tStr << "$";

	Parser psr(tStr.str());
	if (psr.matching()) {
		cout << rStr.str();
	}
	else {
		cout << "invalid input" << endl;
	}

	return 0;
}
