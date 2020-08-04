package mem;

import java.util.Vector;

public class VecterExam {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//백터 예제
		Vector<Integer> v = new Vector<Integer>();
		v.add(1);
		v.add(2);
		v.add(3);
		//백터에 값을넣을떄는 형을 통일 시켜줘야함
		//v.add("4"); -> 에러
		
		for(int i=0; i<v.size();i++) {
			System.out.println(v.get(i));
		}
	}

}
