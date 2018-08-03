Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx3-rdu2.redhat.com ([66.187.233.73]:45056 "EHLO mx1.redhat.com"
        rhost-flags-OK-OK-OK-FAIL) by vger.kernel.org with ESMTP
        id S1732345AbeHCQw1 (ORCPT <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Aug 2018 12:52:27 -0400
From: David Howells <dhowells@redhat.com>
In-Reply-To: <1533307535.4337.415.camel@linux.ibm.com>
References: <1533307535.4337.415.camel@linux.ibm.com> <20180723111432.26830-1-udit.agarwal@nxp.com> <8060.1533226481@warthog.procyon.org.uk> <1533297482.4337.373.camel@linux.ibm.com> <1533306238.4140.1.camel@HansenPartnership.com>
To: Mimi Zohar <zohar@linux.ibm.com>
Cc: dhowells@redhat.com,
        James Bottomley <James.Bottomley@HansenPartnership.com>,
        Udit Agarwal <udit.agarwal@nxp.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key support based on CAAM.
MIME-Version: 1.0
Content-Type: text/plain; charset="us-ascii"
Date: Fri, 03 Aug 2018 15:55:42 +0100
Message-ID: <25968.1533308142@warthog.procyon.org.uk>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

Mimi Zohar <zohar@linux.ibm.com> wrote:

> "trusted" keys are currently being used to decrypt other keys (eg.
> encrypted, ecryptfs, ...).

Can it decrypt both symmetric and asymmetric keys?

David
