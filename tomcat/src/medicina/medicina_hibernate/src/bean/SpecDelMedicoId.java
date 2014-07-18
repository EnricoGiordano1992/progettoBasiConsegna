package bean;

// Generated 17-lug-2014 12.59.14 by Hibernate Tools 3.4.0.CR1

/**
 * SpecDelMedicoId generated by hbm2java
 */
public class SpecDelMedicoId implements java.io.Serializable {

	private String idMedico;
	private String nomeSpecializzazione;

	public SpecDelMedicoId() {
	}

	public SpecDelMedicoId(String idMedico, String nomeSpecializzazione) {
		this.idMedico = idMedico;
		this.nomeSpecializzazione = nomeSpecializzazione;
	}

	public String getIdMedico() {
		return this.idMedico;
	}

	public void setIdMedico(String idMedico) {
		this.idMedico = idMedico;
	}

	public String getNomeSpecializzazione() {
		return this.nomeSpecializzazione;
	}

	public void setNomeSpecializzazione(String nomeSpecializzazione) {
		this.nomeSpecializzazione = nomeSpecializzazione;
	}

	public boolean equals(Object other) {
		if ((this == other))
			return true;
		if ((other == null))
			return false;
		if (!(other instanceof SpecDelMedicoId))
			return false;
		SpecDelMedicoId castOther = (SpecDelMedicoId) other;

		return ((this.getIdMedico() == castOther.getIdMedico()) || (this
				.getIdMedico() != null && castOther.getIdMedico() != null && this
				.getIdMedico().equals(castOther.getIdMedico())))
				&& ((this.getNomeSpecializzazione() == castOther
						.getNomeSpecializzazione()) || (this
						.getNomeSpecializzazione() != null
						&& castOther.getNomeSpecializzazione() != null && this
						.getNomeSpecializzazione().equals(
								castOther.getNomeSpecializzazione())));
	}

	public int hashCode() {
		int result = 17;

		result = 37 * result
				+ (getIdMedico() == null ? 0 : this.getIdMedico().hashCode());
		result = 37
				* result
				+ (getNomeSpecializzazione() == null ? 0 : this
						.getNomeSpecializzazione().hashCode());
		return result;
	}

}