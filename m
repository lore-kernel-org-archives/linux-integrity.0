Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from metis.ext.pengutronix.de ([85.220.165.71]:44263 "EHLO
        metis.ext.pengutronix.de" rhost-flags-OK-OK-OK-OK) by vger.kernel.org
        with ESMTP id S2387965AbeGWNns (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Mon, 23 Jul 2018 09:43:48 -0400
Message-ID: <1532349756.4604.85.camel@pengutronix.de>
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From: Jan =?ISO-8859-1?Q?L=FCbbe?= <jlu@pengutronix.de>
To: Udit Agarwal <udit.agarwal@nxp.com>,
        "dhowells@redhat.com" <dhowells@redhat.com>,
        "zohar@linux.vnet.ibm.com" <zohar@linux.vnet.ibm.com>,
        "jmorris@namei.org" <jmorris@namei.org>,
        "serge@hallyn.com" <serge@hallyn.com>,
        "linux-integrity@vger.kernel.org" <linux-integrity@vger.kernel.org>,
        "keyrings@vger.kernel.org" <keyrings@vger.kernel.org>,
        "linux-security-module@vger.kernel.org"
        <linux-security-module@vger.kernel.org>,
        "linux-kernel@vger.kernel.org" <linux-kernel@vger.kernel.org>
Cc: Sahil Malhotra <sahil.malhotra@nxp.com>,
        Ruchika Gupta <ruchika.gupta@nxp.com>,
        Horia Geanta <horia.geanta@nxp.com>,
        Aymen Sghaier <aymen.sghaier@nxp.com>
Date: Mon, 23 Jul 2018 14:42:36 +0200
In-Reply-To: <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
         <1532076042.3511.203.camel@pengutronix.de>
         <AM5PR0401MB266047028697BCF2851F8F189E500@AM5PR0401MB2660.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Hi,

On Sat, 2018-07-21 at 14:44 +0000, Udit Agarwal wrote:
> Thanks for sharing the documentation changes and feedback.
> 
> Below are the answers to the questions:
> 
> 1. Currently the secure key patch series has been added  to support
> only data blobs.
> It is not supporting key blobs as of now, we have thought of adding
> that support in future.

OK. Do have a plan how the key blobs would be represented in the
keyring? It seems it would need to be some sort of handle instead of
the key data. Would it need a different userspace API?

> 2. Yes secure keys could also be implemented using OPTEE. I will
> change the documentation in next patch version.

Thanks!

Jan
