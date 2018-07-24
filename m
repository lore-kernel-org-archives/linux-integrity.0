Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45882 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S2388309AbeGXOll (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Tue, 24 Jul 2018 10:41:41 -0400
Received: from pps.filterd (m0098417.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w6ODTKBJ061904
        for <linux-integrity@vger.kernel.org>; Tue, 24 Jul 2018 09:35:09 -0400
Received: from e06smtp05.uk.ibm.com (e06smtp05.uk.ibm.com [195.75.94.101])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2ke34ndxcr-1
        (version=TLSv1.2 cipher=AES256-GCM-SHA384 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Tue, 24 Jul 2018 09:35:09 -0400
Received: from localhost
        by e06smtp05.uk.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <zohar@linux.ibm.com>;
        Tue, 24 Jul 2018 14:35:07 +0100
Subject: Re: [PATCH 1/2] security/keys/secure_key: Adds the secure key
 support based on CAAM.
From: Mimi Zohar <zohar@linux.ibm.com>
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
Date: Tue, 24 Jul 2018 09:34:50 -0400
In-Reply-To: <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
References: <20180720054656.29143-1-udit.agarwal@nxp.com>
         <1532302451.6206.22.camel@linux.ibm.com>
         <AM5PR0401MB2660B8C1DD5ED9989239EF009E550@AM5PR0401MB2660.eurprd04.prod.outlook.com>
Content-Type: text/plain; charset="UTF-8"
Mime-Version: 1.0
Message-Id: <1532439290.3277.52.camel@linux.ibm.com>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>

On Tue, 2018-07-24 at 12:31 +0000, Udit Agarwal wrote:
> Yes the secure keys and CAAM are correlated. Secure keys depends on
> NXP CAAM crypto HW accelerator.  Secure key is a random data of
> length X (passed using keyctl command) & derived using CAAM. Blob of
> this data is also created using CAAM. Only blob is visible to user
> space.

The term "secure keys" is really generic.  What makes the "secure
keys" secure?  We introduced "trusted keys", because TPM 1.2 didn't
support symmetric keys.  We shouldn't just duplicate "trusted keys"
for different HW, but improve upon it (eg. symmetric keys never leave
the device).

The new key type should define generic methods, which are implemented
for NXP CAAM rypto HW accelerator as an example.

Mimi
