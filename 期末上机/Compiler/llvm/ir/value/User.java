package llvm.ir.value;

import java.util.ArrayList;

// User类是Value的子类，表示可以使用其他Value对象的Value
public abstract class User extends Value {
    protected ArrayList<Value> operands;

    public User() {
		this.operands = new ArrayList<>();
	}

	public User(Value...operands) {
		this.operands = new ArrayList<>();
		addOperand(operands);
	}

	public User(String name, Value...operands) {
		super(name);
		this.operands = new ArrayList<>();
		addOperand(operands);
	}

	public void addValue(int index,Value value) {
		value.addUse(new Use(value, this));
		operands.add(index, value);
	}

	public void addOperand(Value...values) {
		for (Value value : values) {
			value.addUse(new Use(value, this));
			operands.add(value);
		}
	}
    public ArrayList<Value> getValues() {
		return operands;
	}

    public void removeUse() {
		for (Value operand : operands) {
			operand.useList.removeIf(use -> use.getUser().equals(this));
		}
	}

	//将使用的Value由from替换为to
	public void replaceUse(Value from, Value to) {
		for (int i = 0; i < operands.size(); i++) {
			if (operands.get(i).equals(from)) {
				operands.set(i, to);
				// 维护useList
				to.addUse(new Use(to, this));
				to.useList.removeIf(use -> use.getUser().equals(from));
			}
		}
	}

	/**
	 * 将第一处使用的from替换为to
	 * @param from 要替换的Value
	 * @param to 替换后的Value
	 */
	public void replaceFirstUse(Value from, Value to) {
		for (int i = 0; i < operands.size(); i++) {
			if (operands.get(i).equals(from)) {
				operands.set(i, to);
				// 维护useList
				to.addUse(new Use(to, this));
				to.useList.removeIf(use -> use.getUser().equals(from));
				break;
			}
		}
	}
}
