/*
소수의 합과 최솟값 구하기
*/
#include <iostream>
using namespace std;

bool isPrime(int num)
{
	bool b = true;
	for (int j = 2; j <= sqrt(num); j++)
	{
		if (num % j == 0)//소수아님
		{
			b = false;
			break;
		}
	}
	return b;
}

int main()
{
	int M, N, answer[2] = {0,0};
	cout << "시작 끝 : ";
	cin >> M >> N;

	for (int i = M; i <= N; i++){
		if (isPrime(i))
		{
			answer[0] += i;
			if (answer[1] == 0) answer[1] = i;
			cout << i << " ";
		}
	}

	if (answer[1] == 0)
		cout << -1 << endl;
	else
		cout << endl << "합 : " << answer[0] << endl << "최솟값 : " << answer[1] << endl;
	
	return 0;
}