package bean;

// Generated 17-lug-2014 12.59.14 by Hibernate Tools 3.4.0.CR1

/**
 * Contraddizioni generated by hbm2java
 */
public class Contraddizioni implements java.io.Serializable {

	private ContraddizioniId id;
	private Diagnosi diagnosi;
	private Sintomi sintomi;

	public Contraddizioni() {
	}

	public Contraddizioni(ContraddizioniId id, Diagnosi diagnosi,
			Sintomi sintomi) {
		this.id = id;
		this.diagnosi = diagnosi;
		this.sintomi = sintomi;
	}

	public ContraddizioniId getId() {
		return this.id;
	}

	public void setId(ContraddizioniId id) {
		this.id = id;
	}

	public Diagnosi getDiagnosi() {
		return this.diagnosi;
	}

	public void setDiagnosi(Diagnosi diagnosi) {
		this.diagnosi = diagnosi;
	}

	public Sintomi getSintomi() {
		return this.sintomi;
	}

	public void setSintomi(Sintomi sintomi) {
		this.sintomi = sintomi;
	}

}