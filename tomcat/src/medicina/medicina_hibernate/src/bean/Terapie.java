package bean;

// Generated 17-lug-2014 12.59.14 by Hibernate Tools 3.4.0.CR1

/**
 * Terapie generated by hbm2java
 */
public class Terapie implements java.io.Serializable {

	private TerapieId id;
	private CartellaClinica cartellaClinica;

	public Terapie() {
	}

	public Terapie(TerapieId id, CartellaClinica cartellaClinica) {
		this.id = id;
		this.cartellaClinica = cartellaClinica;
	}

	public TerapieId getId() {
		return this.id;
	}

	public void setId(TerapieId id) {
		this.id = id;
	}

	public CartellaClinica getCartellaClinica() {
		return this.cartellaClinica;
	}

	public void setCartellaClinica(CartellaClinica cartellaClinica) {
		this.cartellaClinica = cartellaClinica;
	}

}
