package bean;

// Generated 17-lug-2014 12.59.14 by Hibernate Tools 3.4.0.CR1

import java.util.Date;
import java.util.HashSet;
import java.util.Set;

/**
 * CartellaClinica generated by hbm2java
 */
public class CartellaClinica implements java.io.Serializable {

	private String id;
	private Paziente paziente;
	private Date dataRicovero;
	private Date dataDimissione;
	private String motivo;
	private String prognosi;
	private Set terapies = new HashSet(0);
	private Set diagnosis = new HashSet(0);
	private Set sintomis = new HashSet(0);

	public CartellaClinica() {
	}

	public CartellaClinica(String id, Date dataRicovero, String motivo) {
		this.id = id;
		this.dataRicovero = dataRicovero;
		this.motivo = motivo;
	}

	public CartellaClinica(String id, Paziente paziente, Date dataRicovero,
			Date dataDimissione, String motivo, String prognosi, Set terapies,
			Set diagnosis, Set sintomis) {
		this.id = id;
		this.paziente = paziente;
		this.dataRicovero = dataRicovero;
		this.dataDimissione = dataDimissione;
		this.motivo = motivo;
		this.prognosi = prognosi;
		this.terapies = terapies;
		this.diagnosis = diagnosis;
		this.sintomis = sintomis;
	}

	public String getId() {
		return this.id;
	}

	public void setId(String id) {
		this.id = id;
	}

	public Paziente getPaziente() {
		return this.paziente;
	}

	public void setPaziente(Paziente paziente) {
		this.paziente = paziente;
	}

	public Date getDataRicovero() {
		return this.dataRicovero;
	}

	public void setDataRicovero(Date dataRicovero) {
		this.dataRicovero = dataRicovero;
	}

	public Date getDataDimissione() {
		return this.dataDimissione;
	}

	public void setDataDimissione(Date dataDimissione) {
		this.dataDimissione = dataDimissione;
	}

	public String getMotivo() {
		return this.motivo;
	}

	public void setMotivo(String motivo) {
		this.motivo = motivo;
	}

	public String getPrognosi() {
		return this.prognosi;
	}

	public void setPrognosi(String prognosi) {
		this.prognosi = prognosi;
	}

	public Set getTerapies() {
		return this.terapies;
	}

	public void setTerapies(Set terapies) {
		this.terapies = terapies;
	}

	public Set getDiagnosis() {
		return this.diagnosis;
	}

	public void setDiagnosis(Set diagnosis) {
		this.diagnosis = diagnosis;
	}

	public Set getSintomis() {
		return this.sintomis;
	}

	public void setSintomis(Set sintomis) {
		this.sintomis = sintomis;
	}

}
