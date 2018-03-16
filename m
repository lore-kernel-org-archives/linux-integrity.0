Return-Path: <linux-integrity-owner@vger.kernel.org>
Received: from mx0b-001b2d01.pphosted.com ([148.163.158.5]:45243 "EHLO
        mx0a-001b2d01.pphosted.com" rhost-flags-OK-OK-OK-FAIL)
        by vger.kernel.org with ESMTP id S1751233AbeCPVix (ORCPT
        <rfc822;linux-integrity@vger.kernel.org>);
        Fri, 16 Mar 2018 17:38:53 -0400
Received: from pps.filterd (m0098421.ppops.net [127.0.0.1])
        by mx0a-001b2d01.pphosted.com (8.16.0.22/8.16.0.22) with SMTP id w2GLY2X6051007
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 17:38:52 -0400
Received: from e34.co.us.ibm.com (e34.co.us.ibm.com [32.97.110.152])
        by mx0a-001b2d01.pphosted.com with ESMTP id 2grhf09pjq-1
        (version=TLSv1.2 cipher=AES256-SHA256 bits=256 verify=NOT)
        for <linux-integrity@vger.kernel.org>; Fri, 16 Mar 2018 17:38:52 -0400
Received: from localhost
        by e34.co.us.ibm.com with IBM ESMTP SMTP Gateway: Authorized Use Only! Violators will be prosecuted
        for <linux-integrity@vger.kernel.org> from <bauerman@linux.vnet.ibm.com>;
        Fri, 16 Mar 2018 15:38:51 -0600
References: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
From: Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com>
To: linux-integrity@vger.kernel.org
Cc: linux-security-module@vger.kernel.org, keyrings@vger.kernel.org,
        linux-crypto@vger.kernel.org, linuxppc-dev@lists.ozlabs.org,
        linux-kernel@vger.kernel.org,
        Mimi Zohar <zohar@linux.vnet.ibm.com>,
        Dmitry Kasatkin <dmitry.kasatkin@gmail.com>,
        James Morris <jmorris@namei.org>,
        "Serge E. Hallyn" <serge@hallyn.com>,
        David Howells <dhowells@redhat.com>,
        David Woodhouse <dwmw2@infradead.org>,
        Jessica Yu <jeyu@kernel.org>,
        Herbert Xu <herbert@gondor.apana.org.au>,
        "David S. Miller" <davem@davemloft.net>,
        "AKASHI\, Takahiro" <takahiro.akashi@linaro.org>
Subject: Re: [PATCH v6 00/12] Appended signatures support for IMA appraisal
In-reply-to: <20180316203837.10174-1-bauerman@linux.vnet.ibm.com>
Date: Fri, 16 Mar 2018 18:38:38 -0300
MIME-Version: 1.0
Content-Type: text/plain
Message-Id: <87zi37og4h.fsf@morokweng.localdomain>
Sender: linux-integrity-owner@vger.kernel.org
List-ID: <linux-integrity.vger.kernel.org>


Thiago Jung Bauermann <bauerman@linux.vnet.ibm.com> writes:

> Now the modsig is only ignored if it references a signature that is not
> present in IMA's keyring (or if there's a parsing error, obviously). If the

The above should read "Now the modsig is only ignored if it references a
*key* that is not present in IMA's keyring".

Sorry, I only noticed the mistake after sending the emails.

--
Thiago Jung Bauermann
IBM Linux Technology Center
