package mem;

import java.util.Vector;

public class VecterExam {

	public static void main(String[] args) {
		// TODO Auto-generated method stub
		//���� ����
		Vector<Integer> v = new Vector<Integer>();
		v.add(1);
		v.add(2);
		v.add(3);
		//���Ϳ� ������������ ���� ���� ���������
		//v.add("4"); -> ����
		
		for(int i=0; i<v.size();i++) {
			System.out.println(v.get(i));
		}
	}

}
