package llvm.ir.value;

import java.util.ArrayList;

import dataStructure.STT.STTQue;
import llvm.ir.NameAllocator;
import llvm.ir.value.Type.*;

public abstract class Value {
    
    protected String name;//名字
    // protected STTQue.Element symbol;
    protected ArrayList<Use> useList;//使用情况
    protected ArrayList<User> userList;
    protected String addr;

    public ValueType valuetype;

    public Value() {
		useList = new ArrayList<>();
	}

	public Value(String name) {
		this.name = name;
		useList = new ArrayList<>();
	}

	// public Value(STTQue.Element symbol) {
	// 	this.symbol = symbol;
	// 	useList = new ArrayList<>();
	// }

	// public Value(String name, STTQue.Element symbol) {
	// 	this.name = name;
	// 	this.symbol = symbol;
	// 	useList = new ArrayList<>();
	// }
    public void addUse(Use use) {
		useList.add(use);
	}

	public String getName() {
		System.out.println("befor: "+name);
        if (name == null) {
            name = NameAllocator.getInstance().alloc();
        }
		System.out.println("after: "+name);
        return name;
    }

	public void setName(String name) {
		this.name = name;
	}

	public ArrayList<Use> getUseList() {
		return useList;
	}

	// public STTQue.Element getSymbol() {
	// 	return symbol;
	// }

	// public void setSymbol(STTQue.Element symbol) {
	// 	this.symbol = symbol;
	// }

	public String getAddr() {
		return addr;
	}

	public void setAddr(String addr) {
		this.addr = addr;
	}

    public void setValueType(ValueType Type){
        this.valuetype=Type;
    }

    public ValueType getValueType(){
        return valuetype;
    }

	public void replaceUsed(Value value) {
		for (Use use : useList) {
			use.getUser().replaceUse(this, value);
		}
	}

    // 省略其他方法...
}



