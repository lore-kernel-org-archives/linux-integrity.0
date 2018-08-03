Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0a-001b2d01.pphosted.com ([148.163.156.1]:42340 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-OK)
        by vger.kernel.org with ESMTP id S1727227AbeHCNyg (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 3 Aug 2018 09:54:36 -0400
Received: from pps.filterd (m0098410.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w73BsJKH138334
        for <linux-integrity@vger.kernel.org>; Fri, 3 Aug 2018 07:58:36 -0400
Received: from e06smtp04.uk.ibm.com (e06smtp04.uk.ibm.com [195.75.94.100])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2kmne22s6y-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 03 Aug 2018 07:58:35 -0400
Received: from localhost
        by e06smtp04.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Fri, 3 Aug 2018 12:58:20 +0100
Subject: Re: [PATCH v2 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From: Mimi Zohar <zohar@linux.ibm.com>
To: David Howells <dhowells@redhat.com>,
        Udit Agarwal <udit.agarwal@nxp.com>
Cc: zohar@linux.vnet.ibm.com, jmorris@namei.org, serge@hallyn.com,
        denkenz@gmail.com, linux-integrity@vger.kernel.org,
        keyrings@vger.kernel.org, linux-security-module@vger.kernel.org,
        linux-kernel@vger.kernel.org, sahil.malhotra@nxp.com,
        ruchika.gupta@nxp.com, horia.geanta@nxp.com, aymen.sghaier@nxp.com
Date: Fri, 03 Aug 2018 07:58:02 -0400
In-Reply-To: <8060.1533226481@warthog.procyon.org.uk>
References: <20180723111432.26830-1-udit.agarwal@nxp.com>
         <8060.1533226481@warthog.procyon.org.uk>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1533297482.4337.373.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Thu, 2018-08-02 at 17:14 +0100, David Howells wrote:
> Udit Agarwal <udit.agarwal@nxp.com> wrote:
> 
> > +==========
> > +Secure Key
> > +==========
> > +
> > +Secure key is the new type added to kernel key ring service.
> > +Secure key is a symmetric type key of minimum length 32 bytes
> > +and with maximum possible length to be 128 bytes. It is produced
> > +in kernel using the CAAM crypto engine. Userspace can only see
> > +the blob for the corresponding key. All the blobs are displayed
> > +or loaded in hex ascii.
> 
> To echo Mimi, this sounds suspiciously like it should have a generic
> interface, not one that's specifically tied to one piece of hardware -
> particularly if it's named with generic "secure".
> 
> Can you convert this into a "symmetric" type and make the backend pluggable?

TPM 1.2 didn't support symmetric keys.  For this reason, the TPM
"unseals" the random number, used as a symmetric key, and returns the
"unsealed" data to the kernel.

Does anyone know if CAAM or TPM 2.0 have support for symmetric keys?
 If they have symmetric key support, there would be no need for the
symmetric key ever to leave the device in the clear.  The device would
unseal/decrypt data, such as an encrypted key.

The "symmetric" key type would be a generic interface for different
devices.

Mimi
