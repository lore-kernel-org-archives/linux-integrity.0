Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:59702 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727128AbeHCRUo (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Aug 2018 13:20:44 -0400
Received: from pps.filterd (m0098393.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73FJoZJ022277
        for <linux-integrity@vger.kernel.org>; Fri, 3 Aug 2018 11:23:56 -0400
Received: from e06smtp02.uk.ibm.com (e06smtp02.uk.ibm.com [195.75.94.98])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmr1kcm12-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Aug 2018 11:23:56 -0400
Received: from localhost
        by e06smtp02.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Aug 2018 16:23:53 +0100
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>
Cc: James Bottomley <James.Bottomley@HansenPartnership.com>,
        Udit Agarwal <udit.agarwal@nxp.com>, zohar@linux.vnet.ibm.com,
        jmorris@namei.org, serge@hallyn.com, denkenz@gmail.com,
        linux-integrity@vger.kernel.org, keyrings@vger.kernel.org,
        linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date: Fri, 03 Aug 2018 11:23:35 -0400
In-Reply-To: <25968.1533308142@warthog.procyon.org.uk>
References: <1533307535.4337.415.camel@linux.ibm.com>
         <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
         <1533297482.4337.373.camel@linux.ibm.com>
         <1533306238.4140.1.camel@HansenPartnership.com>
         <25968.1533308142@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1533309815.4337.437.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Fri, 2018-08-03 at 15:55 +0100, David Howells wrote:
> Mimi Zohar <zohar@linux.ibm.com> wrote:
> 
> > "trusted" keys are currently being used to decrypt other keys (eg.
> > encrypted, ecryptfs, ...).
> 
> Can it decrypt both symmetric and asymmetric keys?

Yes, the "trusted" key is returned to the caller and is used to
decrypt a datablob.

For an example, refer to encrypted_key_decrypt().  The call
to request_master_key() returns either the "trusted" or "user" type
key, which is used to decrypt the "enccrypted" key type.

Mimi
