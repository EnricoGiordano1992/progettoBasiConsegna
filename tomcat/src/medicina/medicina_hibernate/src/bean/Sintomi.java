package bean;

// Generated 17-lug-2014 12.59.14 by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * Sintomi generated by hbm2java
 */
public class Sintomi implements java.io.Serializable {

	private SintomiId id;
	private CartellaClinica cartellaClinica;
	private String intensita;
	private Date data;
	private Integer durata;
	private Set contraddizionis = new HashSet(0);
	private Set confermes = new HashSet(0);

	public Sintomi() {
	}

	public Sintomi(SintomiId id, CartellaClinica cartellaClinica,
			String intensita, Date data) {
		this.id = id;
		this.cartellaClinica = cartellaClinica;
		this.intensita = intensita;
		this.data = data;
	}

	public Sintomi(SintomiId id, CartellaClinica cartellaClinica,
			String intensita, Date data, Integer durata, Set contraddizionis,
			Set confermes) {
		this.id = id;
		this.cartellaClinica = cartellaClinica;
		this.intensita = intensita;
		this.data = data;
		this.durata = durata;
		this.contraddizionis = contraddizionis;
		this.confermes = confermes;
	}

	public SintomiId getId() {
		return this.id;
	}

	public void setId(SintomiId id) {
		this.id = id;
	}

	public CartellaClinica getCartellaClinica() {
		return this.cartellaClinica;
	}

	public void setCartellaClinica(CartellaClinica cartellaClinica) {
		this.cartellaClinica = cartellaClinica;
	}

	public String getIntensita() {
		return this.intensita;
	}

	public void setIntensita(String intensita) {
		this.intensita = intensita;
	}

	public Date getData() {
		return this.data;
	}

	public void setData(Date data) {
		this.data = data;
	}

	public Integer getDurata() {
		return this.durata;
	}

	public void setDurata(Integer durata) {
		this.durata = durata;
	}

	public Set getContraddizionis() {
		return this.contraddizionis;
	}

	public void setContraddizionis(Set contraddizionis) {
		this.contraddizionis = contraddizionis;
	}

	public Set getConfermes() {
		return this.confermes;
	}

	public void setConfermes(Set confermes) {
		this.confermes = confermes;
	}

}
