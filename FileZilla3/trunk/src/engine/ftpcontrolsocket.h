#ifndef __FTPCONTROLSOCKET_H__
#define __FTPCONTROLSOCKET_H__

#include "logging_private.h"
#include "ControlSocket.h"

class CFtpControlSocket : public CControlSocket
{
public:
	CFtpControlSocket(CFileZillaEngine *pEngine);
	virtual ~CFtpControlSocket();

protected:
	virtual void OnConnect(wxSocketEvent &event);
	virtual void OnReceive(wxSocketEvent &event);

	virtual bool Send(wxString str);

	void ParseResponse();
	int GetReplyCode() const;

	void Logon();

	wxString m_ReceiveBuffer;
	wxString m_MultilineResponseCode;
};

#endif
