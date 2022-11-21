package vo;

public class Cash {
	private int cashNo;
	//private Categoty category; // INNER JOIN -> Cash타입
	private int categoryNo; //FK -> INNER JOIN -> Map타입 사용
	private long cashPrice;
	private String cashMemo;
	private String updatedate;
	private String createdate;
}
