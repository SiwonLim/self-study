/*
정수의 역수 구하기
*/
#include <iostream>
using namespace std;
int reverse(int x)
{
	int answer = 0;
	while (x != 0) {//x > 0으로 조건을 주면 음수는 연산X
		answer = (answer * 10) + x % 10;
		x /= 10;
	}
	return answer;
}

int main()
{
	int x;
	cin >> x;
	cout << reverse(x) << endl;
	return 0;
}